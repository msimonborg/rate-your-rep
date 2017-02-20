class Rep < ActiveRecord::Base
  has_many   :office_locations,
             dependent: :destroy,
             foreign_key: :bioguide_id,
             primary_key: :bioguide_id
  has_many :calls, foreign_key: :bioguide_id, primary_key: :bioguide_id
  has_many :users, through: :calls
  
  validates :bioguide_id, presence: true, uniqueness: true
  validates :official_full, presence: true
  validates :given_name, presence: true
  validates :family_name, presence: true
  validates :honorific_prefix, presence: true
  validates :party_identification, presence: true
end
