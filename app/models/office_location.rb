class OfficeLocation < ActiveRecord::Base
  belongs_to :rep, foreign_key: :bioguide_id, primary_key: :bioguide_id
  
  validates :bioguide_id, :locality, :region, :postal_code, presence: true
end
