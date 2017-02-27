class OfficeLocation < ActiveRecord::Base
  include Callable

  belongs_to :rep, foreign_key: :bioguide_id, primary_key: :bioguide_id
  has_many :calls
  has_many :users, through: :calls

  validates :bioguide_id, :phone, :locality, :region, :postal_code, :office_type, presence: true

  scope :most_called, ->{ select("*, count(calls.id) AS calls_count").
    joins(:calls).
    group("office_locations.id").
    order("calls_count DESC") }

  scope :best_rated, ->{ select("*, avg(calls.rating) AS calls_rating").
    joins(:calls).
    group("office_locations.id").
    order("calls_rating DESC") }
end
