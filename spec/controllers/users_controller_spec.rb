# frozen_string_literal: true

require 'spec_helper'

describe UsersController do
  let(:helpers) { TestHelper.new }

  describe 'Log In' do
    before do
      @user1 = User.create(username: 'Test User',
                           email: 'email@example.com',
                           password: 'password')
    end

    it 'logs in with valid email and password' do
      params = { email: 'email@example.com', password: 'password', path: '/' }
      post '/login', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include("/users/#{@user1.slug}")
    end

    it 'does not log in a user if user\'s email is not found' do
      params = { email: 'wrong_email@bad.com', password: 'password' }
      post '/login', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to_not include('/users')
    end

    it 'does not log in a user if the password doesn\'t match' do
      params = { email: 'email@example.com', password: 'password1' }
      post '/login', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to_not include('/users')
    end
  end

  describe 'Sign Up' do
    it 'succeeds with valid username, email, and password' do
      params = {
        user: {
          username: 'Test User',
          email: 'email@example.com',
          password: 'password'
        }
      }
      post '/signup', params
      user = User.last
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include("/users/#{user.slug}")
    end

    it 'fails with blank username' do
      params = {
        user: {
          username: '',
          email: 'email@example.com',
          password: 'password'
        }
      }
      post '/signup', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to_not include('/users')
    end

    it 'fails with invalid email' do
      params = {
        user: {
          username: 'Test User',
          email: 'email@',
          password: 'password'
        }
      }
      post '/signup', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to_not include('/users')
    end

    it 'fails with blank email' do
      params = {
        user: {
          username: 'Test User',
          email: '',
          password: 'password'
        }
      }
      post '/signup', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to_not include('/users')
    end

    it 'fails with invalid password' do
      params = {
        user: {
          username: 'Test User',
          email: 'email@example.com',
          password: 'passwor'
        }
      }
      post '/signup', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to_not include('/users')
    end

    it 'fails with blank password' do
      params = {
        user: {
          username: 'Test User',
          email: 'email@example.com',
          password: ''
        }
      }
      post '/signup', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to_not include('/users')
    end
  end

  describe 'Log Out' do
    before do
      @user1 = User.create(username: 'Test User',
                           email: 'email@example.com',
                           password: 'password')
    end

    it 'logs out if logged in' do
      params = { email: 'email@example.com', password: 'password', path: '/' }
      post '/login', params
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include("/users/#{@user1.slug}")

      get '/logout'
      expect(last_response.status).to eq(302)
      expect(last_response.location).to_not include('/users')
    end
  end
end
