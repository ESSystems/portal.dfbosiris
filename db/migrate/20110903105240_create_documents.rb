class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :attachable, :polymorphic => true
      t.string  :title
      t.string  :description
      
      t.timestamps
    end
  end
end
