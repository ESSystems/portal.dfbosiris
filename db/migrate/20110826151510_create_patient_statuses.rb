class CreatePatientStatuses < ActiveRecord::Migration
  def change
    create_table :patient_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
