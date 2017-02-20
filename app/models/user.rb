class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true, length: { minimum: 0 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                              on: :create
end
