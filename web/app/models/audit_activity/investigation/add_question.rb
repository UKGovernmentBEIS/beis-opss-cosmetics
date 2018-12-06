class AuditActivity::Investigation::AddQuestion < AuditActivity::Investigation::Add
  def self.from(investigation)
    super(investigation, self.build_title(investigation), self.build_body(investigation))
  end

  def self.build_title(investigation)
    "Question logged: #{investigation.title}"
  end

  def self.build_body(investigation)
    body = "**Question details**<br>"
    body += "Attachment: **#{investigation.documents.first.filename.to_s.gsub('_', '\_')}**<br>" if investigation.documents.attached?
    body += "<br>#{investigation.description}" if investigation.description.present?
    body += self.build_reporter_details(investigation.reporter) if investigation.reporter.present?
    body
  end
end
