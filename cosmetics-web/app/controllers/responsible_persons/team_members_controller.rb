class ResponsiblePersons::TeamMembersController < ApplicationController
  before_action :set_responsible_person
  before_action :authorize_responsible_person, only: %i[new create]
  skip_before_action :create_or_join_responsible_person
  skip_before_action :authenticate_user!, only: %i[join new_account]

  def new
    @team_member = @responsible_person.pending_responsible_person_users.build(team_member_params)
  end

  def create
    pending_user = @responsible_person.pending_responsible_person_users
                                      .find_by(email_address: team_member_params[:email_address])
    @team_member = if pending_user&.expired?
                     pending_user_with_renewed_expiration(pending_user)
                   else
                     @responsible_person.pending_responsible_person_users.build(team_member_params)
                   end
    @responsible_person.save
    return render :new if @responsible_person.errors.any?

    send_invite_email
    redirect_to responsible_person_team_members_path(@responsible_person)
  end

  def join
    pending = PendingResponsiblePersonUser.find(params[:id])
    # TODO: What to do when the invitation is expired?
    invited_user = SubmitUser.find_by(email: pending.email_address)
    return render("join_signed_in_as_another_user", locals: { existing_user: invited_user }) if current_user && current_user.email != pending.email_address
    return redirect_to new_account_responsible_person_team_member_path(@responsible_person, pending) unless invited_user
    return authenticate_user! unless current_user

    # User at this point is signed as the invited user.
    ActiveRecord::Base.transaction do
      @responsible_person.add_user(current_user)
      Rails.logger.info "Team member added to Responsible Person"
      PendingResponsiblePersonUser.where(email_address: current_user.email).delete_all
    end

    redirect_to responsible_person_notifications_path(@responsible_person)
  end

  def sign_out_before_joining
    sign_out
    redirect_to join_responsible_person_team_member_path(params[:responsible_person_id], params[:id])
  end

  def new_account
    pending = PendingResponsiblePersonUser.find(params[:id])
    @new_account_form = Registration::NewAccountForm.new(email: pending.email_address)
  end

private

  def set_responsible_person
    @responsible_person = ResponsiblePerson.find(params[:responsible_person_id])
  end

  def authorize_responsible_person
    authorize @responsible_person, :show?
  end

  def team_member_params
    params.fetch(:team_member, {}).permit(
      :email_address,
    )
  end

  def pending_user_with_renewed_expiration(pending_user)
    pending_user.tap do |p|
      p.set_expiration
      p.save!
    end
  end

  def send_invite_email
    NotifyMailer.send_responsible_person_invite_email(
      @responsible_person,
      @team_member,
      current_user.name,
    ).deliver_later
  end

  # See: SecondaryAuthenticationConcern
  def current_operation
    SecondaryAuthentication::INVITE_USER
  end
end
