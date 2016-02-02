require 'rails_helper'

RSpec.describe User, type: :model do

  it 'responds to attributes email, password (& confirmation), auth_token and role' do
    user = User.new

    expect(user).to respond_to(:email)
    expect(user).to respond_to(:password)
    expect(user).to respond_to(:password_confirmation)
    expect(user).to respond_to(:auth_token)
    expect(user).to respond_to(:role)
  end


  it 'has valid factories' do
    user = FactoryGirl.build(:user)

    expect(user).to be_valid
    expect(user.save).to be_truthy
  end


  it 'validates presence of email & password' do
    user = FactoryGirl.build(:user)
    
    expect(user).to validate_presence_of(:email)
    expect(user).to validate_presence_of(:password)
  end


  it 'validates uniqueness of auth_token' do
    user = FactoryGirl.build(:user)
 
    expect(user).to validate_uniqueness_of(:auth_token)
  end


  it 'validates presence of role' do
    user = FactoryGirl.build(:user)
 
    expect(user).to validate_presence_of(:role)
  end


  it 'validates case-insensitive uniqueness of email' do
    user = FactoryGirl.build(:user)

    expect(user).to validate_uniqueness_of(:email).case_insensitive
  end


  describe '#generate_auth_token!' do
    let(:user) { FactoryGirl.create(:user) }

    it 'generates a token' do
      user.generate_auth_token!

      expect(user.auth_token).not_to be_empty
    end
    

    it 'generates another token when one already has been taken' do
      user.generate_auth_token!
      existing_token = user.auth_token
      new_user = FactoryGirl.create(:user, auth_token: existing_token)

      expect(new_user.auth_token).not_to eql user.auth_token
    end
  end
  
end
