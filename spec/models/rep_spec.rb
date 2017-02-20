require 'spec_helper'

describe 'Rep' do
  before do
    @rep = Rep.create(bioguide_id: 'A000DS32',
                      official_full: 'Madam Senator',
                      given_name: 'Madam',
                      family_name: 'Senator',
                      honorific_prefix: 'Honorable',
                      party_identification: 'Worker\'s Party')
  end

  describe 'creating reps' do
    it 'persists to the database with valid input' do
      expect(Rep.count).to eq(1)
    end

    it 'can be found by Bioguide ID' do
      rep = Rep.find_by bioguide_id: 'A000DS32'

      expect(rep).to eq(@rep)
      expect(rep.official_full).to eq('Madam Senator')
      expect(rep.given_name).to eq('Madam')
      expect(rep.family_name).to eq('Senator')
      expect(rep.honorific_prefix).to eq('Honorable')
      expect(rep.party_identification).to eq('Worker\'s Party')
    end

    it 'has a unique Bioguide ID' do
      rep = Rep.create(bioguide_id: 'A000DS32',
                       official_full: 'Other Rep',
                       given_name: 'Other',
                       family_name: 'Rep',
                       honorific_prefix: 'Senator',
                       party_identification: 'People\'s Party')

      expect(rep.id).to eq(nil)
      expect(Rep.count).to eq(1)
    end

    it 'requires bioguide_id to persist' do
      rep = Rep.create(bioguide_id: '',
                       official_full: 'Other Rep',
                       given_name: 'Other',
                       family_name: 'Rep',
                       honorific_prefix: 'Senator',
                       party_identification: 'People\'s Party')

      expect(rep.id).to eq(nil)
      expect(Rep.count).to eq(1)
    end

    it 'requires official_full name to persist' do
      rep = Rep.create(bioguide_id: 'OtherID',
                       official_full: '',
                       given_name: 'Other',
                       family_name: 'Rep',
                       honorific_prefix: 'Senator',
                       party_identification: 'People\'s Party')

      expect(rep.id).to eq(nil)
      expect(Rep.count).to eq(1)
    end

    it 'requires given_name to persist' do
      rep = Rep.create(bioguide_id: 'OtherID',
                       official_full: 'Other Rep',
                       given_name: '',
                       family_name: 'Rep',
                       honorific_prefix: 'Senator',
                       party_identification: 'People\'s Party')

      expect(rep.id).to eq(nil)
      expect(Rep.count).to eq(1)
    end

    it 'requires family_name to persist' do
      rep = Rep.create(bioguide_id: 'OtherID',
                       official_full: 'Other Rep',
                       given_name: 'Other',
                       family_name: '',
                       honorific_prefix: 'Senator',
                       party_identification: 'People\'s Party')

      expect(rep.id).to eq(nil)
      expect(Rep.count).to eq(1)
    end

    it 'requires honorific_prefix to persist' do
      rep = Rep.create(bioguide_id: 'OtherID',
                       official_full: 'Other Rep',
                       given_name: 'Other',
                       family_name: 'Rep',
                       honorific_prefix: '',
                       party_identification: 'People\'s Party')

      expect(rep.id).to eq(nil)
      expect(Rep.count).to eq(1)
    end

    it 'requires party_identification to persist' do
      rep = Rep.create(bioguide_id: 'OtherID',
                       official_full: 'Other Rep',
                       given_name: 'Other',
                       family_name: 'Rep',
                       honorific_prefix: 'Senator',
                       party_identification: '')

      expect(rep.id).to eq(nil)
      expect(Rep.count).to eq(1)
    end
  end

  describe 'associating reps' do
    it 'has many office locations associated by Bioguide ID' do
      office1 = OfficeLocation.create(bioguide_id: @rep.bioguide_id,
                                      locality: 'locality1',
                                      region: 'region1',
                                      postal_code: 'postal_code1')
      office2 = OfficeLocation.create(bioguide_id: @rep.bioguide_id,
                                      locality: 'locality2',
                                      region: 'region2',
                                      postal_code: 'postal_code2')

      expect(@rep.office_locations.count).to eq(2)
    end

    it 'only has office locations with the same Bioguide ID' do
      office1 = OfficeLocation.create(bioguide_id: @rep.bioguide_id,
                                      locality: 'locality1',
                                      region: 'region1',
                                      postal_code: 'postal_code1')
      office2 = OfficeLocation.create(bioguide_id: 'different',
                                      locality: 'locality2',
                                      region: 'region2',
                                      postal_code: 'postal_code2')

      expect(@rep.office_locations.count).to eq(1)
      expect(@rep.office_locations).to include(office1)
      expect(@rep.office_locations).to_not include(office2)
    end
  end
end
