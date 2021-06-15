class PoisonCentres::NotificationsController < SearchApplicationController
  def index
    @form = NotificationSearchForm.new(search_params)
    @form.valid?

    @result = search_notifications(10)
    @notifications = @result.records
  end

  def show
    @notification = Notification.find_by reference_number: params[:reference_number]
    authorize @notification, policy_class: PoisonCentreNotificationPolicy
    if current_user&.poison_centre_user?
      render "show_poison_centre"
    else
      @contact_person = @notification.responsible_person.contact_persons.first
      render "show_msa"
    end
  end

private

  def search_notifications(page_size)
    query = ElasticsearchQuery.new(keyword: @form.q, category: @form.category, from_date: @form.from_date, to_date: @form.to_date)
    Notification.full_search(query).paginate(page: params[:page], per_page: page_size)
  end

  def search_params
    date_attributes = [
      :date_filter,
      :date_from_day,
      :date_from_month,
      :date_from_year,
      :date_to_day,
      :date_to_month,
      :date_to_year,
      :date_exact_day,
      :date_exact_month,
      :date_exact_year
    ]

    params.fetch(:notification_search_form, {}).permit(:q, :category, *date_attributes)
  end
end
