class Rep < ActiveRecord::Base
  extend APIFindable::ClassMethods
  include APIFindable::InstanceMethods

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

  scope :most_called, ->{ select("reps.*, count(calls.id) AS calls_count").
    joins(:calls).
    group("reps.id").
    order("calls_count DESC") }

  scope :best_rated, ->{ select("reps.*, avg(calls.rating) AS calls_rating").
    joins(:calls).
    group("reps.id").
    order("calls_rating DESC") }

  attr_accessor :url, :photo, :twitter, :facebook, :youtube, :instagram, :state, :district
end
