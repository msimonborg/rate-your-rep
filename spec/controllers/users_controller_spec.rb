require 'spec_helper'

describe UsersController do
  let(:helpers) { TestHelper.new }

  describe 'Log In' do
    before do
      @user1 = User.create(name: 'Test User', email: 'email@example.com', password: 'password')
    end

    it 'logs in with valid email and password' do
      params = { email: 'email@example.com', password: 'password' }
      post '/login', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include("/users/#{@user1.id}")
    end

    it 'does not log in a user if user\'s email is not found' do
      params = { email: 'wrong_email@bad.com', password: 'password' }
      post '/login', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include('/login')
    end

    it 'does not log in a user if the password doesn\'t match' do
      params = { email: 'email@example.com', password: 'password1' }
      post '/login', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include('/login')
    end
  end

  describe 'Sign Up' do
    it 'succeeds with valid name, email, and password' do
      params = { name: 'Test User', email: 'email@example.com', password: 'password' }
      post '/signup', params
      user = User.last
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include("/users/#{user.id}")
    end

    it 'fails with blank name' do
      params = { name: '', email: 'email@example.com', password: 'password' }
      post '/signup', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include('/signup')
    end

    it 'fails with invalid email' do
      params = { name: 'Test User', email: 'email@', password: 'password' }
      post '/signup', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include('/signup')
    end

    it 'fails with blank email' do
      params = { name: 'Test User', email: '', password: 'password' }
      post '/signup', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include('/signup')
    end

    it 'fails with invalid password' do
      params = { name: 'Test User', email: 'email@example.com', password: 'passwor' }
      post '/signup', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include('/signup')
    end

    it 'fails with blank email' do
      params = { name: 'Test User', email: 'email@example.com', password: '' }
      post '/signup', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include('/signup')
    end
  end
end
