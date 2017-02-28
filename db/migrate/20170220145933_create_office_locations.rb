# frozen_string_literal: true
class CreateOfficeLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :office_locations do |t|
      t.string :bioguide_id
      t.string :locality
      t.string :region
      t.string :postal_code

      t.timestamps
    end
  end
end
