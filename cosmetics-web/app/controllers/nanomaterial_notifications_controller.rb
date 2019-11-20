class NanomaterialNotificationsController < ApplicationController
  before_action :set_responsible_person_from_url, only: %w[index new create]

  before_action :set_nanomaterial_notification_from_url, only: %i[notified_to_eu update_notified_to_eu upload_file update_file review name update_name submit confirmation_page]

  def index; end

  def new
    @nanomaterial_notification = @responsible_person.nanomaterial_notifications.new
  end

  def create
    @nanomaterial_notification = @responsible_person.nanomaterial_notifications.new
    @nanomaterial_notification.iupac_name = params[:nanomaterial_notification][:iupac_name]
    @nanomaterial_notification.user_id = current_user.id

    if @nanomaterial_notification.save(context: :add_iupac_name)
      redirect_to notified_to_eu_nanomaterial_path(@nanomaterial_notification)
    else
      render "new"
    end
  end

  def name; end

  def update_name
    @nanomaterial_notification.iupac_name = params[:nanomaterial_notification][:iupac_name]

    if @nanomaterial_notification.save(context: :add_iupac_name)
      redirect_to review_responsible_person_nanomaterial_path(@nanomaterial_notification)
    else
      render "name"
    end
  end

  def notified_to_eu; end

  def update_notified_to_eu
    if @nanomaterial_notification.update_with_context(eu_notification_params, :eu_notification)
      redirect_to upload_file_nanomaterial_path(@nanomaterial_notification)
    else
      render "notified_to_eu"
    end
  end

  def upload_file; end

  def update_file
    file = params.fetch(:nanomaterial_notification, {})[:file]

    if file
      @nanomaterial_notification.file.attach(file)
    end

    if @nanomaterial_notification.save(context: :upload_file)
      redirect_to review_nanomaterial_path(@nanomaterial_notification)
    else
      render "upload_file"
    end
  end

  def review; end

  def submit
    @nanomaterial_notification.submit!

    redirect_to confirmation_nanomaterial_path(@nanomaterial_notification)
  end

  def confirmation_page
    render "confirmation_page"
  end

private

  def eu_notification_params
    params.permit(:eu_notified, :notified_to_eu_on)
  end

  def set_nanomaterial_notification_from_url
    @nanomaterial_notification = NanomaterialNotification.find(params[:id])
    @responsible_person = @nanomaterial_notification.responsible_person
    authorize @responsible_person, :show?
  end

  def set_responsible_person_from_url
    @responsible_person = ResponsiblePerson.find(params[:responsible_person_id])
    authorize @responsible_person, :show?
  end
end
