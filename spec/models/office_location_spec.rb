require 'spec_helper'

describe 'OfficeLocation' do
  before do
    @office1 = OfficeLocation.create(bioguide_id: 'A000DS32',
                                    locality: 'locality1',
                                    region: 'region1',
                                    postal_code: 'postal_code1')

    @rep1 = Rep.create(bioguide_id: 'A000DS32',
                       official_full: 'Madam Senator',
                       given_name: 'Madam',
                       family_name: 'Senator',
                       honorific_prefix: 'Honorable',
                       party_identification: 'Worker\'s Party')
  end

  describe 'creating office locations' do
    it 'persists to the database with valid input' do
      expect(OfficeLocation.count).to eq(1)
    end

    it 'can be found by Bioguide ID' do
      office2 = OfficeLocation.find_by bioguide_id: 'A000DS32'

      expect(office2).to eq(@office1)
      expect(office2.locality).to eq('locality1')
      expect(office2.region).to eq('region1')
      expect(office2.postal_code).to eq('postal_code1')
    end

    it 'requires bioguide_id to persist' do
      office2 = OfficeLocation.create(bioguide_id: '',
                              locality: 'locality2',
                              region: 'region2',
                              postal_code: 'postal_code2')

      expect(office2.id).to eq(nil)
      expect(OfficeLocation.count).to eq(1)
    end

    it 'requires locality to persist' do
      office2 = OfficeLocation.create(bioguide_id: 'bioguide_id2',
                              locality: '',
                              region: 'region2',
                              postal_code: 'postal_code2')

      expect(office2.id).to eq(nil)
      expect(OfficeLocation.count).to eq(1)
    end

    it 'requires region to persist' do
      office2 = OfficeLocation.create(bioguide_id: 'bioguide_id2',
                              locality: 'locality2',
                              region: '',
                              postal_code: 'postal_code2')

      expect(office2.id).to eq(nil)
      expect(OfficeLocation.count).to eq(1)
    end

    it 'requires postal_code to persist' do
      office2 = OfficeLocation.create(bioguide_id: 'bioguide_id2',
                              locality: 'locality2',
                              region: 'region2',
                              postal_code: '')

      expect(office2.id).to eq(nil)
      expect(OfficeLocation.count).to eq(1)
    end
  end

  describe 'associating office locations' do
    it 'belongs to the Rep with the same Bioguide ID' do
      expect(@office1.rep).to eq(@rep1)
    end

    it 'does not belong to a Rep with a different Bioguide ID' do
      rep2 = Rep.create(bioguide_id: 'Different',
                        official_full: 'Madam Senator',
                        given_name: 'Madam',
                        family_name: 'Senator',
                        honorific_prefix: 'Honorable',
                        party_identification: 'Worker\'s Party')

      expect(@office1.rep).to eq(@rep1)
      expect(@office1.rep).to_not eq(rep2)
    end
  end
end
