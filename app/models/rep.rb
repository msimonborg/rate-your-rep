class Rep < ActiveRecord::Base
  validates :bioguide_id, presence: true, uniqueness: true
  validates :official_full, presence: true
  validates :given_name, presence: true
  validates :family_name, presence: true
  validates :honorific_prefix, presence: true
  validates :party_identification, presence: true
end
