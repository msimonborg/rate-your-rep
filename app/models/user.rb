class User < ActiveRecord::Base
  has_many :calls
  has_many :reps, through: :calls
  has_many :office_locations, through: :calls

  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { minimum: 0 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                              on: :create
end
