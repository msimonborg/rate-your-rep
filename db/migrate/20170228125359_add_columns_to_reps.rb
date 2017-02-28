# frozen_string_literal: true
class AddColumnsToReps < ActiveRecord::Migration[5.0]
  def change
    add_column :reps, :state, :string
    add_column :reps, :vcard, :string
    add_column :reps, :photo, :string
    add_column :reps, :district, :string
    add_column :reps, :url, :string
    add_column :reps, :twitter, :string
    add_column :reps, :youtube, :string
    add_column :reps, :facebook, :string
    add_column :reps, :instagram, :string
  end
end
