# frozen_string_literal: true

require 'pyr'

# Get Rep and OfficeLocation data from the Phone Your Rep API and persist
# (most) of it to the database.
# https://www.github.com/phoneyourrep/phone-your-rep
module APIFindable
  def self.included(base)
    base.extend(ClassMethods)
  end

  def update_rep_personal_data(rep)
    self.active           = rep.active
    self.given_name       = rep.first
    self.family_name      = rep.last
    self.additional_name  = rep.middle
    self.honorific_suffix = rep.suffix
  end

  def update_rep_social_data(rep)
    self.vcard     = parse_vcard_url(rep)
    self.url       = rep.url
    self.twitter   = rep.twitter
    self.youtube   = rep.youtube
    self.facebook  = rep.facebook
    self.instagram = rep.instagram
  end

  def update_rep_political_data(rep)
    self.district             = rep.district.code if rep.district
    self.official_full        = rep.official_full
    self.honorific_prefix     = rep.role
    self.party_identification = rep.party
    self.state                = rep.state.name
    self.photo                = rep.photo
  end

  def parse_vcard_url(rep)
    capitol_office = rep.office_locations.where(office_type: 'capitol').first
    if capitol_office
      capitol_office.v_card_link
    else
      district_office = rep.office_locations.where(office_type: 'district').first
      district_office.v_card_link if district_office
    end
  end

  # Methods that make calls to the API, find, create, and return objects
  # based on the data.
  module ClassMethods
    def search_by_geo(params = {})
      @response = PYR.call :reps do |resource|
        resource.lat  = params[:lat]
        resource.long = params[:lng]
      end
      parse_reps
    end

    def search_by_bioguide_id(bioguide_id)
      @response = PYR.call :reps, bioguide_id
      parse_reps
    end

    def fetch_full_index
      @response = PYR.call :reps
      parse_reps
    end

    def parse_reps
      @response.objects.map do |rep|
        db_rep = Rep.find_or_create_by bioguide_id: rep.bioguide_id
        parse_office_locations(rep)
        db_rep.update_rep_political_data(rep)
        db_rep.update_rep_personal_data(rep)
        db_rep.update_rep_social_data(rep)
        db_rep.save
        db_rep
      end
    end

    def parse_office_locations(rep)
      rep.office_locations.each do |office|
        o = OfficeLocation.find_or_create_by office_id:   office.office_id,
                                             bioguide_id: office.bioguide_id,
                                             locality:    office.city,
                                             region:      office.state,
                                             postal_code: office.zip,
                                             office_type: office.office_type
        # Update the phone since it can be subject to change
        o.update phone: office.phone, active: office.active
      end
    end
  end
end
