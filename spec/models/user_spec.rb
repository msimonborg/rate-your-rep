require 'spec_helper'

describe 'User' do
  before do
    @user = User.create(username: 'Test User', email: 'email@example.com', password: 'password')
  end

  it 'has a secure password' do
    expect(@user.authenticate('dog')).to eq(false)
    expect(@user.authenticate('password')).to eq(@user)
  end

  it 'has a unique email' do
    @user = User.new(username: 'Another User', email: 'email@example.com', password: 'password')
    expect(@user.save).to eq(false)
  end

  it 'requires a username' do
    @user = User.new(username: '', email: 'another@email.com', password: 'password')
    expect(@user.save).to eq(false)
  end

  it 'requires an email' do
    @user = User.new(username: 'Another User', email: '', password: 'password')
    expect(@user.save).to eq(false)
  end

  it 'requires a valid email' do
    @user = User.new(username: 'Another User', email: 'email', password: 'password')
    expect(@user.save).to eq(false)

    @user = User.new(username: 'Another User', email: 'email@email', password: 'password')
    expect(@user.save).to eq(false)

    @user = User.new(username: 'Another User', email: '@email.com', password: 'password')
    expect(@user.save).to eq(false)
  end

  it 'requires a password' do
    @user = User.new(username: 'Another User', email: 'another@email.com', password: '')
    expect(@user.save).to eq(false)
  end

  it 'password must be at least 8 characters long' do
    @user = User.new(username: 'Another User', email: 'another@email.com', password: 'passwor')
    expect(@user.save).to eq(false)
  end
end
