# frozen_string_literal: true
class CreateCalls < ActiveRecord::Migration[5.0]
  def change
    create_table :calls do |t|
      t.string :bioguide_id
      t.string :comments
      t.boolean :got_through, default: false
      t.boolean :busy, default: false
      t.boolean :voice_mail, default: false
      t.boolean :mailbox_full, default: false
      t.integer :rating
      t.integer :user_id
      t.integer :office_location_id

      t.timestamps
    end
  end
end
