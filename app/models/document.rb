class Document < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  
  has_attached_file :document
  
  def osiris_url
    "http://#{OSIRIS_SERVER_NAME}/upload/#{self.class.name.downcase.pluralize}/#{self.document_fingerprint}/#{self.document_file_name}"
  end
end
