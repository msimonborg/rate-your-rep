class AddColumnsToOfficeLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :office_locations, :phone, :string
    add_column :office_locations, :office_type, :string
  end
end
