module EmailFormValidation
  extend ActiveSupport::Concern

  included do
    attribute :email

    validates :email,
              email: {
                message: I18n.t(:wrong_format, scope: :email_form_validation),
                if: ->(sign_in_form) { sign_in_form.email.present? },
              }
    validates_presence_of :email, message: I18n.t(:blank, scope: :email_form_validation)
  end
end
