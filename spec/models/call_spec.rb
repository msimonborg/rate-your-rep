# frozen_string_literal: true

require 'spec_helper'

describe 'Call' do
  before do
    @office1 = OfficeLocation.create(bioguide_id: 'A000DS32',
                                     locality: 'locality1',
                                     region: 'region1',
                                     postal_code: 'postal_code1',
                                     office_type: 'district')

    @rep1 = Rep.create(bioguide_id: 'A000DS32',
                       official_full: 'Madam Senator',
                       given_name: 'Madam',
                       family_name: 'Senator',
                       honorific_prefix: 'Honorable',
                       party_identification: 'Worker\'s Party')

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

  describe 'creating calls' do
    it 'persists to the database with valid input' do
      expect(Call.count).to eq(2)
    end

    it 'can be found by Bioguide ID' do
      calls = Call.where bioguide_id: 'A000DS32'

      expect(calls.count).to eq(2)
      expect(calls).to include(@call1)
      expect(calls).to include(@call2)
    end

    it 'requires bioguide_id to persist' do
      call3 = Call.create(comments: 'very frustrated',
                          mailbox_full: true,
                          rating: 2,
                          user: @user1,
                          office_location: @office1)

      expect(call3.id).to eq(nil)
      expect(Call.count).to eq(2)
    end

    it 'requires rating to persist' do
      call3 = Call.create(bioguide_id: @rep1.bioguide_id,
                          comments: 'very frustrated',
                          mailbox_full: true,
                          user: @user1,
                          office_location: @office1)

      expect(call3.id).to eq(nil)
      expect(Call.count).to eq(2)
    end

    it 'must have a rating between 1 and 5' do
      call3 = Call.create(bioguide_id: @rep1.bioguide_id,
                          comments: 'very frustrated',
                          mailbox_full: true,
                          rating: 6,
                          user: @user1,
                          office_location: @office1)

      expect(call3.id).to eq(nil)
      expect(Call.count).to eq(2)
      expect(call3.errors.full_messages.first).to include(
        '6 is not a valid rating'
      )

      call4 = Call.create(bioguide_id: @rep1.bioguide_id,
                          comments: 'very frustrated',
                          mailbox_full: true,
                          rating: 0,
                          user: @user1,
                          office_location: @office1)

      expect(call4.id).to eq(nil)
      expect(Call.count).to eq(2)
      expect(call4.errors.full_messages.first).to include(
        '0 is not a valid rating'
      )
    end
  end
end
