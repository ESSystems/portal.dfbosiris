class AddCaseReferenceNumberToReferral < ActiveRecord::Migration
  def change
    add_column :referrals, :case_reference_number, :string
  end
end
