class Call < ActiveRecord::Base
  belongs_to :user
  belongs_to :office_location
  belongs_to :rep, foreign_key: :bioguide_id, primary_key: :bioguide_id

  validates :bioguide_id, :rating, presence: true
  validates :rating, inclusion: { in: (1..5).to_a,
    message: "%{value} is not a valid rating" }

  scope :this_week, ->{ where(created_at: (Time.now.midnight - 7.day)..Time.now) }
  scope :time_sorted, ->{ order('created_at DESC') }
  scope :last_call, ->{ time_sorted.limit(1).first }
  scope :stars, ->{ average('rating').to_i.round }
  scope :that_connected, ->{ where(got_through: true) }
  scope :that_were_busy, ->{ where(busy: true) }
  scope :that_went_to_voice_mail, ->{ where(voice_mail: true) }
  scope :that_hit_a_full_mailbox, ->{ where(mailbox_full: true) }

  def user_update(params)
    # When a user updates, reset boolean attributes to false except those
    # that are true in the params hash.
    update({ got_through:  false,
             busy:         false,
             voice_mail:   false,
             mailbox_full: false }.merge!(params))
  end

  def time
    created_at.localtime.strftime("%-m/%-d/%y at %l:%M%P")
  end

  def rep_party
    rep.party_identification
  end

  def rep_title
    rep.honorific_prefix
  end

  def rep_name
    rep.official_full
  end

  def rep_bioguide_id
    bioguide_id
  end

  def phone_number
    office_location.phone
  end

  def office_locality
    "#{office_location.locality} Office"
  end

  def no_comments?
    comments.blank?
  end

  def user_slug
    user.slug
  end
end
