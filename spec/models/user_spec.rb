require 'spec_helper'

describe 'User' do
  before do
    @user1 = User.create(username: 'Test User', email: 'email@example.com', password: 'password')
  end

  describe 'creating users' do
    it 'persists to the database with valid data' do
      expect(User.count).to eq(1)
    end

    it 'adds a slug after creation' do
      expect(@user1).to respond_to(:slug)
      expect(@user1.slug).to eq('test-user')
    end

    it 'has a secure password' do
      expect(@user1.authenticate('dog')).to eq(false)
      expect(@user1.authenticate('password')).to eq(@user1)
    end

    it 'has a unique email' do
      user2 = User.new(username: 'Another User', email: 'email@example.com', password: 'password')
      expect(user2.save).to eq(false)
      expect(User.count).to eq(1)
    end

    it 'has a unique username' do
      user2 = User.new(username: 'Test User', email: 'otheremail@example.com', password: 'password')
      expect(user2.save).to eq(false)
      expect(User.count).to eq(1)
    end

    it 'requires a username' do
      user2 = User.new(username: '', email: 'another@email.com', password: 'password')
      expect(user2.save).to eq(false)
      expect(User.count).to eq(1)
    end

    it 'requires an email' do
      user2 = User.new(username: 'Another User', email: '', password: 'password')
      expect(user2.save).to eq(false)
      expect(User.count).to eq(1)
    end

    it 'requires a valid email' do
      user2 = User.new(username: 'Another User', email: 'email', password: 'password')
      expect(user2.save).to eq(false)
      expect(User.count).to eq(1)

      user2 = User.new(username: 'Another User', email: 'email@email', password: 'password')
      expect(user2.save).to eq(false)
      expect(User.count).to eq(1)

      user2 = User.new(username: 'Another User', email: '@email.com', password: 'password')
      expect(user2.save).to eq(false)
      expect(User.count).to eq(1)
    end

    it 'requires a password' do
      user2 = User.new(username: 'Another User', email: 'another@email.com', password: '')
      expect(user2.save).to eq(false)
      expect(User.count).to eq(1)
    end

    it 'password must be at least 8 characters long' do
      user2 = User.new(username: 'Another User', email: 'another@email.com', password: 'passwor')
      expect(user2.save).to eq(false)
      expect(User.count).to eq(1)
    end
  end

  describe 'associations' do
    before do
      @rep1 = Rep.create(bioguide_id: 'A000DS32',
                        official_full: 'Madam Senator',
                        given_name: 'Madam',
                        family_name: 'Senator',
                        honorific_prefix: 'Honorable',
                        party_identification: 'Worker\'s Party')

      @office1 = OfficeLocation.create(bioguide_id: @rep1.bioguide_id,
                                       locality: 'locality1',
                                       region: 'region1',
                                       postal_code: 'postal_code1',
                                       office_type: 'district',
                                       phone: '123-456-7890')

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

    it 'has many calls' do
      expect(@user1.calls_count).to eq(2)
      expect(@user1.calls).to include(@call1)
      expect(@user1.calls).to include(@call2)
    end

    it 'has many reps through calls' do
      expect(@user1.reps.count).to eq(2)
      expect(@user1.reps.distinct.count).to eq(1)
      expect(@user1.reps.distinct).to include(@rep1)
    end

    it 'has many office locations through calls' do
      expect(@user1.office_locations.count).to eq(2)
      expect(@user1.distinct_office_locations_count).to eq(1)
      expect(@user1.distinct_office_locations).to include(@office1)
    end
  end
end
