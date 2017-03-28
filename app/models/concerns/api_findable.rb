# frozen_string_literal: true

# Get Rep and OfficeLocation data from the Phone Your Rep API and persist
# (most) of it to the database.
# https://www.github.com/phoneyourrep/phone-your-rep
module APIFindable
  def self.included(base)
    base.extend(ClassMethods)
  end

  def update_rep_personal_data(rep_hash)
    self.active           = rep_hash['active']
    self.given_name       = rep_hash['first']
    self.family_name      = rep_hash['last']
    self.additional_name  = rep_hash['middle']
    self.honorific_suffix = rep_hash['suffix']
  end

  def update_rep_social_data(rep_hash)
    self.vcard     = parse_vcard_url(rep_hash)
    self.url       = rep_hash['url']
    self.twitter   = rep_hash['twitter']
    self.youtube   = rep_hash['youtube']
    self.facebook  = rep_hash['facebook']
    self.instagram = rep_hash['instagram']
  end

  def update_rep_political_data(rep_hash)
    self.district  = rep_hash['district']['code'] if rep_hash['district']
    self.official_full        = rep_hash['official_full']
    self.honorific_prefix     = rep_hash['role']
    self.party_identification = rep_hash['party']
    self.state                = rep_hash['state']['name']
    self.photo                = rep_hash['photo']
  end

  def parse_vcard_url(rep_hash)
    capitol_office_hash = rep_hash['office_locations'].find do |office|
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

    def fetch_full_index
      url = 'https://phone-your-rep.herokuapp.com/reps'
      @response = HTTParty.get(url).parsed_response
      parse_reps
    end

    def parse_reps
      @response.map do |rep_hash|
        db_rep = Rep.find_or_create_by bioguide_id: rep_hash['bioguide_id']
        parse_office_locations(rep_hash)
        db_rep.update_rep_political_data(rep_hash)
        db_rep.update_rep_personal_data(rep_hash)
        db_rep.update_rep_social_data(rep_hash)
        db_rep.save
        db_rep
      end
    end

    def parse_office_locations(rep_hash)
      rep_hash['office_locations'].each do |office|
        o = OfficeLocation.find_or_create_by(office_id:   office['office_id'],
                                             bioguide_id: office['bioguide_id'],
                                             locality:    office['city'],
                                             region:      office['state'],
                                             postal_code: office['zip'],
                                             office_type: office['office_type'])
        # Update the phone since it can be subject to change
        o.update(phone: office['phone'], active: office['active'])
      end
    end
  end
end
