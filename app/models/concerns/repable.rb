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

  def rep_bioguide_id
    bioguide_id
  end
end
