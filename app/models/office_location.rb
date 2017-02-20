class OfficeLocation < ActiveRecord::Base
  belongs_to :rep, foreign_key: :bioguide_id, primary_key: :bioguide_id
  has_many :calls, foreign_key: :bioguide_id, primary_key: :bioguide_id
  has_many :users, through: :calls

  validates :bioguide_id, :locality, :region, :postal_code, :office_type, presence: true
end
