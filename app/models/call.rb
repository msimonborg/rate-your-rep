class Call < ActiveRecord::Base
  belongs_to :user
  belongs_to :office_location
  belongs_to :rep, foreign_key: :bioguide_id, primary_key: :bioguide_id

  validates :bioguide_id, :rating, presence: true
  validates :rating, inclusion: { in: (1..5).to_a,
    message: "%{value} is not a valid rating" }

  scope :this_week, ->{ where(created_at: (Time.now.midnight - 7.day)..Time.now) }
  scope :last_call, ->{ order('created_at DESC').limit(1).first }
  scope :stars, ->{ average('rating').to_i.round }

  def time
    created_at.localtime.strftime("%-m/%-d/%y at %l:%M%P")
  end
end
