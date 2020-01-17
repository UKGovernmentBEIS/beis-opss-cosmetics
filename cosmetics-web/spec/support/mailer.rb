# frozen_string_literal: true

# rubocop:disable RSpec/AnyInstance
RSpec.shared_context "with stubbed mailer", shared_context: :metadata do
  before { allow_any_instance_of(NotifyMailer).to receive(:mail).and_return(true) }
end

RSpec.configure do |rspec|
  rspec.include_context "with stubbed mailer", with_stubbed_mailer: true
end
# rubocop:enable RSpec/AnyInstance

def stub_notify_mailer
  result = double
  allow(result).to receive(:deliver_later)
  allow(NotifyMailer).to receive(:send_contact_person_verification_email) { result }
  allow(NotifyMailer).to receive(:send_responsible_person_invite_email) { result }
end
