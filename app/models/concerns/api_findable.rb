# frozen_string_literal: true

# Get Rep and OfficeLocation data from the Phone Your Rep API and persist
# (most) of it to the database.
# https://www.github.com/phoneyourrep/phone-your-rep
module APIFindable
  def self.included(base)
    base.extend(ClassMethods)
  end

  def add_rep_attributes(rep)
    self.url       = rep['url']
    self.photo     = rep['photo']
    self.twitter   = rep['twitter']
    self.youtube   = rep['youtube']
    self.facebook  = rep['facebook']
    self.instagram = rep['instagram']
    self.state     = rep['state']['name']
    self.vcard     = parse_vcard_url(rep)
    self.district  = rep['district']['code'] if rep['district']
  end

  def parse_vcard_url(rep)
    capitol_office_hash = rep['office_locations'].find do |office|
      office['office_type'] == 'capitol'
    end

    capitol_office_hash['v_card_link']
  end

  # Methods that make calls to the API, find, create, and return objects
  # based on the data.
  module ClassMethods
    def search_by_geo(params = {})
      lat = params[:lat]
      lng = params[:lng]
      url = "https://phone-your-rep.herokuapp.com/reps?lat=#{lat}&long=#{lng}"
      @response = HTTParty.get(url).parsed_response
      parse_reps
    end

    def search_by_bioguide_id(bioguide_id)
      url = "https://phone-your-rep.herokuapp.com/reps/#{bioguide_id}"
      @response = [HTTParty.get(url).parsed_response]
      parse_reps
    end

    def parse_reps
      @response.map do |rep|
        db_rep = Rep.find_by bioguide_id: rep['bioguide_id']
        db_rep = create_rep_from_api(rep) unless db_rep
        next unless db_rep.valid?
        parse_office_locations(rep)
        db_rep.add_rep_attributes(rep)
        db_rep
      end
    end

    def create_rep_from_api(rep)
      Rep.create do |r|
        r.bioguide_id          = rep['bioguide_id']
        r.official_full        = rep['official_full']
        r.given_name           = rep['first']
        r.family_name          = rep['last']
        r.additional_name      = rep['middle']
        r.honorific_suffix     = rep['suffix']
        r.honorific_prefix     = rep['role']
        r.party_identification = rep['party']
      end
    end

    def parse_office_locations(rep)
      rep['office_locations'].each do |office|
        db_ol = OfficeLocation.find_or_create_by(
          bioguide_id: office['bioguide_id'],
          locality:    office['city'],
          region:      office['state'],
          postal_code: office['zip'],
          office_type: office['office_type']
        )
        # Update the phone since it can be subject to change
        db_ol.update(phone: office['phone'])
      end
    end
  end
end
