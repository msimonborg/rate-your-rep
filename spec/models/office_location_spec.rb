# frozen_string_literal: true
require 'spec_helper'

describe 'OfficeLocation' do
  before do
    @office1 = OfficeLocation.create(bioguide_id: 'A000DS32',
                                     locality: 'locality1',
                                     region: 'region1',
                                     postal_code: 'postal_code1',
                                     office_type: 'district',
                                     phone: '123-456-7890')

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
      expect(office2.phone).to eq('123-456-7890')
    end

    it 'requires bioguide_id to persist' do
      office2 = OfficeLocation.create(bioguide_id: '',
                                      locality: 'locality2',
                                      region: 'region2',
                                      postal_code: 'postal_code2',
                                      phone: '123-456-7890')

      expect(office2.id).to eq(nil)
      expect(OfficeLocation.count).to eq(1)
    end

    it 'requires locality to persist' do
      office2 = OfficeLocation.create(bioguide_id: 'bioguide_id2',
                                      locality: '',
                                      region: 'region2',
                                      postal_code: 'postal_code2',
                                      phone: '123-456-7890')

      expect(office2.id).to eq(nil)
      expect(OfficeLocation.count).to eq(1)
    end

    it 'requires region to persist' do
      office2 = OfficeLocation.create(bioguide_id: 'bioguide_id2',
                                      locality: 'locality2',
                                      region: '',
                                      postal_code: 'postal_code2',
                                      phone: '123-456-7890')

      expect(office2.id).to eq(nil)
      expect(OfficeLocation.count).to eq(1)
    end

    it 'requires postal_code to persist' do
      office2 = OfficeLocation.create(bioguide_id: 'bioguide_id2',
                                      locality: 'locality2',
                                      region: 'region2',
                                      postal_code: '',
                                      phone: '123-456-7890')

      expect(office2.id).to eq(nil)
      expect(OfficeLocation.count).to eq(1)
    end

    it 'requires phone to persist' do
      office2 = OfficeLocation.create(bioguide_id: 'bioguide_id2',
                                      locality: 'locality2',
                                      region: 'region2',
                                      postal_code: 'postal_code2',
                                      phone: '')

      expect(office2.id).to eq(nil)
      expect(OfficeLocation.count).to eq(1)
    end
  end

  describe 'associations' do
    before do
      @user1 = User.create(username: 'Test User',
                           email: 'email@example.com',
                           password: 'password')

      @call1 = Call.create(bioguide_id: @rep1.bioguide_id,
                           comments: 'very satisfied',
                           got_through: true,
                           rating: 4,
                           user: @user1,
                           office_location: @office1)

      @call2 = Call.create(bioguide_id: @rep1.bioguide_id,
                           comments: 'very frustrated',
                           mailbox_full: true,
                           rating: 2,
                           user: @user1,
                           office_location: @office1)
    end

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

    it 'has many calls' do
      expect(@office1.calls_count).to eq(2)
      expect(@office1.calls).to include(@call1)
      expect(@office1.calls).to include(@call2)
    end

    it 'has many users through calls' do
      expect(@office1.users.count).to eq(2)
      expect(@office1.users.distinct.count).to eq(1)
      expect(@office1.users.distinct).to include(@user1)
    end

    it 'only has the right calls' do
      call3 = Call.create(bioguide_id: 'different',
                          comments: 'very frustrated',
                          mailbox_full: true,
                          rating: 2,
                          user: @user1,
                          office_location_id: 10)

      expect(@office1.calls_count).to eq(2)
      expect(@office1.calls).to include(@call1)
      expect(@office1.calls).to include(@call2)
      expect(@office1.calls).to_not include(call3)
    end
  end
end
