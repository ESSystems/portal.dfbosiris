class RenameReferralColumns < ActiveRecord::Migration
  def change
    rename_column :referrals, :specific_requirements, :job_information
    rename_column :referrals, :advice, :history
  end
end
