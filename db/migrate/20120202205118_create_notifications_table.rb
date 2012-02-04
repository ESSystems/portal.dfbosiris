class CreateNotificationsTable < ActiveRecord::Migration
  def up
    create_table :notifications do |n|
      n.text :message
      n.string :notifier_model
      n.integer :notifier_id
      n.string :target_model
      n.integer :target_id
      n.boolean :email_sent
      n.timestamp :email_sent_date
      n.boolean :read
      n.timestamp :created
    end
  end

  def down
    drop_table :notifications
  end
end