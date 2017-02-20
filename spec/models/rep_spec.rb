require 'spec_helper'

describe 'Rep' do
  describe 'creating reps' do
    before do
      @rep = Rep.create(bioguide_id: 'A000DS32',
                        official_full: 'Madam Senator',
                        given_name: 'Madam',
                        family_name: 'Senator',
                        honorific_prefix: 'Honorable',
                        party_identification: 'Worker\'s Party')
    end

    it 'saves to the database with valid input' do
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
end
