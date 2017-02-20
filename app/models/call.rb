class Call < ActiveRecord::Base
  belongs_to :user
  belongs_to :office_location, foreign_key: :bioguide_id, primary_key: :bioguide_id
  belongs_to :rep, foreign_key: :bioguide_id, primary_key: :bioguide_id

  validates :bioguide_id, :rating, presence: true
end
