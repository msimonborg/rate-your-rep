class User < ActiveRecord::Base
  include Callable

  has_many :calls
  has_many :reps, through: :calls
  has_many :office_locations, through: :calls

  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                              on: :create
  before_create :add_slug

  scope :most_calls, ->{ select("users.*, count(calls.id) AS calls_count").
    joins(:calls).
    group("users.id").
    order("calls_count DESC") }

  def add_slug
    self.slug = username.
                split(' ').
                join('-').
                gsub(/(\.|!|\?|\(|\)|&|%|@)/, '').
                tr('$', 's').
                downcase
  end

  def time_sorted_calls_including_reps_and_offices
    time_sorted_calls.includes(:rep, :office_location)
  end

  def distinct_office_locations
    office_locations.distinct
  end

  def distinct_office_locations_count
    distinct_office_locations.count
  end
end
