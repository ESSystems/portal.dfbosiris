class DeviseCreateReferrers < ActiveRecord::Migration
  def self.up
    create_table(:referrers) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.references :person

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :referrers, :email,                :unique => true
    add_index :referrers, :reset_password_token, :unique => true
    # add_index :referrers, :confirmation_token,   :unique => true
    # add_index :referrers, :unlock_token,         :unique => true
    # add_index :referrers, :authentication_token, :unique => true
  end

  def self.down
    drop_table :referrers
  end
end
