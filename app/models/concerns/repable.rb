# frozen_string_literal: true

# Shared methods for objects that belong_to a rep
module Repable
  def rep_party
    rep.party_identification
  end

  def rep_title
    rep.honorific_prefix
  end

  def rep_name
    rep.official_full
  end

  # Objects that belong_to a :rep have the same :bioguide_id as their parent.
  # It is the foreign key on the table. :rep_bioguide_id acts as an alias
  # for :bioguide_id to make the connection more obvious in the views.
  def rep_bioguide_id
    bioguide_id
  end
end
