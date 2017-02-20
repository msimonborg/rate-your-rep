class CreateReps < ActiveRecord::Migration[5.0]
  def change
    create_table :reps do |t|
      t.string :bioguide_id
      t.string :official_full
      t.string :family_name
      t.string :given_name
      t.string :additional_name
      t.string :honorific_prefix
      t.string :honorific_suffix
      t.string :party_identification

      t.timestamps
    end
  end
end
