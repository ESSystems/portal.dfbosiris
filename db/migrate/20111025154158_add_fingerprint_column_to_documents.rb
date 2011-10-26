class AddFingerprintColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :document_fingerprint, :string
  end
end
