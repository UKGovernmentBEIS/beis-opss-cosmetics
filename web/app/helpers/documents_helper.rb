module DocumentsHelper
  include FileConcern

  def set_parent
    @parent = Investigation.find(params[:investigation_id]) if params[:investigation_id]
    @parent = Product.find(params[:product_id]) if params[:product_id]
  end

  def save_file
    @file_blob.metadata.update(get_attachment_metadata_params(:file))
    @file_blob.metadata["updated"] = Time.current
    attach_blobs_to_list(@file_blob, file_collection)
    audit_class::Add.from(@file_blob, @parent) if @parent.class == Investigation
    redirect_to @parent
  end

  def audit_class
    AuditActivity::Document
  end

  def file_collection
    @parent.documents
  end

  def document_type_label(document_type)
    case document_type
    when :correspondence_originator
      "Correspondence from originator"
    when :correspondence_business
      "Correspondence from business"
    when :correspondence_other
      "Correspondence from other"
    when :tech_specs
      "Technical specifications"
    when :test_results
      "Test results"
    when :risk_assessment
      "Risk assessment"
    else
      "Other"
    end
  end

  def document_filetype_label(document)
    return "Audio" if document.audio?
    return "Image" if document.image?
    return "Video" if document.video?
    return "Text" if document.text?

    case document.content_type
    when "application/pdf"
      "PDF"
    when "application/msword",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      "Word Document"
    when "application/vnd.ms-excel",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "Excel Document"
    when "application/vnd.ms-powerpoint",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      "PowerPoint Document"
    else
      document_file_extension(document).upcase
    end
  end

  def document_file_extension(document)
    File.extname(document.filename.to_s)&.remove(".")&.upcase
  end

  def formatted_file_updated_date(file)
    if file.blob.metadata[:updated]
      "Updated #{Time.zone.parse(file.blob.metadata[:updated]).strftime('%d/%m/%Y')}"
    end
  end
end
