class GuidanceController < PubliclyAccessibleController
  skip_before_action :require_secondary_authentication

  def how_to_notify_nanomaterials; end

  def how_to_prepare_images_for_notification; end

  def how_to_set_up_authenticator_app; end
end
