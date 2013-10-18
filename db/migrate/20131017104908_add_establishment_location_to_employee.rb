class AddEstablishmentLocationToEmployee < ActiveRecord::Migration
  def change
    add_column :demployees, :establishment_location, :string
  end
end
