# frozen_string_literal: true

# Rep object is created from data retrieved by an API call
class Rep < ActiveRecord::Base
  include APIFindable
  include Callable

  has_many :calls, foreign_key: :bioguide_id, primary_key: :bioguide_id
  has_many :users, through: :calls
  has_many :office_locations, dependent: :destroy,
                              foreign_key: :bioguide_id,
                              primary_key: :bioguide_id

  validates :bioguide_id, presence: true, uniqueness: true
  validates :official_full,
            :given_name,
            :family_name,
            :honorific_prefix,
            :party_identification,
            presence: true

  scope :most_called, -> {
    select('reps.*, count(calls.id) AS calls_count').
      joins(:calls).
      group('reps.id').
      order('calls_count DESC')
  }

  scope :best_rated, -> {
    select('reps.*, avg(calls.rating) AS calls_rating').
      joins(:calls).
      group('reps.id').
      order('calls_rating DESC')
  }

  # These attributes are pulled in from the API whenever a Rep's show page
  # is viewed, or is found by location.
  # Since they might change they are not persisted to the database,
  # and instead are stored in memory while the object is in use.
  attr_accessor :url,
                :photo,
                :twitter,
                :facebook,
                :youtube,
                :instagram,
                :state,
                :district,
                :vcard

  def office_locations_count
    office_locations.count
  end
end
