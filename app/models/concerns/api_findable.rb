module APIFindable
  module ClassMethods
    def find_by_geo(params={})
      lat = params[:lat]
      lng = params[:lng]
      url = "https://phone-your-rep.herokuapp.com/reps?lat=#{lat}&long=#{lng}"
      @response = HTTParty.get(url).parsed_response
      parse_reps
    end

    def parse_reps
      @response.map do |rep|
        db_rep = Rep.find_by bioguide_id: rep['bioguide_id']
        db_rep = create_rep_from_api(rep) unless db_rep
        return unless db_rep
        db_rep.office_locations << parse_office_locations(rep)
        db_rep.add_rep_attributes(rep)
        db_rep
      end
    end

    def create_rep_from_api(rep)
      Rep.new do |r|
        r.bioguide_id          = rep['bioguide_id']
        r.official_full        = rep['official_full']
        r.given_name           = rep['first']
        r.family_name          = rep['last']
        r.additional_name      = rep['middle']
        r.honorific_suffix     = rep['suffix']
        r.honorific_prefix     = rep['role']
        r.party_identification = rep['party']
        r.save
      end
    end

    def parse_office_locations(rep)
      rep['office_locations'].map do |office|
        db_ol = OfficeLocation.find_by bioguide_id: office['bioguide_id'],
                                       locality:    office['city'],
                                       region:      office['state'],
                                       postal_code: office['zip'],
                                       office_type: office['office_type']
        db_ol.update(phone: office['phone']) if db_ol
        db_ol = create_ol_from_api(office) unless db_ol
        db_ol
      end
    end

    def create_ol_from_api(office)
      OfficeLocation.new do |o|
        o.bioguide_id = office['bioguide_id']
        o.locality    = office['city']
        o.region      = office['state']
        o.postal_code = office['zip']
        o.office_type = office['office_type']
        o.phone       = office['phone']
        o.save
      end
    end
  end

  module InstanceMethods
    def add_rep_attributes(rep)
      self.url       = rep['url']
      self.photo     = rep['photo']
      self.twitter   = rep['twitter']
      self.facebook  = rep['facebook']
      self.youtube   = rep['youtube']
      self.instagram = rep['instagram']
      self.state     = rep['state']['name']
      self.district  = rep['district']['code'] if rep['district']
    end
  end
end
