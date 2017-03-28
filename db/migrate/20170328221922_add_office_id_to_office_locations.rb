# frozen_string_literal: true
class AddOfficeIdToOfficeLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :office_locations, :office_id, :string
  end
end
