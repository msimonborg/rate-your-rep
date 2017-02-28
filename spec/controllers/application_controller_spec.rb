# frozen_string_literal: true
require 'spec_helper'

describe ApplicationController do
  let(:helpers) { TestHelper.new }

  describe 'Sessions' do
    before do
      @user1 = User.create(username: 'Test User',
                           email: 'email@example.com',
                           password: 'password')
      helpers.session[:user_id] = @user1.id
    end

    it 'knows if a user is logged in' do
      expect(helpers.logged_in?).to eq(true)
    end

    it 'knows who the current user is' do
      user2 = User.create(username: 'User Two',
                          email: 'another@email.com',
                          password: 'password')
      expect(helpers.current_user).to eq(@user1)
      expect(helpers.current_user).to_not eq(user2)
    end
  end

  describe 'Homepage' do
    it 'loads the homepage' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('<title>Rate Your Rep</title>')
    end
  end
end
