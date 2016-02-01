require 'rails_helper'


class Authentication
  include Authenticable

  def request
  end

  def response
  end

  def render
  end
end


RSpec.describe Authenticable do

  let(:user)           { FactoryGirl.create(:user) }
  let(:authentication) { Authentication.new }

  def set_http_header!(user)
    request.headers['Authorization'] = user.auth_token
  end


  describe '#current_user' do

    before(:each) do
      allow(authentication).to receive(:request) { request }
    end


    context 'when no user on session' do
      it 'returns nil' do
        expect(authentication.current_user).to be_nil
      end
    end


    context 'when user on session' do
      before { set_http_header!(user) }

      it 'returns current user' do
        expect(authentication.current_user).to eql user
      end
    end

  end



  # describe '#authenticate_with_token' do
  #   context 'when no token is sent in header' do

  #     before(:each) do
  #       allow(authentication).to  receive(:current_user)  { nil }
  #       allow(response).to        receive(:response_code) { 401 }
  #       allow(response).to        receive(:body)          { {'errors' => 'Not authenticated'}.to_json }
  #       allow(authentication).to  receive(:response)      { response }
  #     end

  #     it 'returns an error' do
  #       json_response = JSON.parse(response.body, symbolize_names: true)
  #       expect(json_response[:errors]).to eql 'Not authenticated'
  #     end

  #     it 'responds with http status code 401 / unauthorized' do
  #       expect(response).to have_http_status(:unauthorized)
  #     end

  #   end
  # end


  describe '#user_signed_in?' do
    context 'when there is a user on session' do

      before(:each) do
        allow(authentication).to receive(:request) { request }
        set_http_header!(user)
      end
      
      it 'returns true for user_signed_in?' do
        expect(authentication.user_signed_in?).to be true
      end
    end


    context 'when there is no user on session' do

      before(:each) do
        allow(authentication).to receive(:request) { request }
      end

      it 'returns false for user_signed_in?' do
        expect(authentication.user_signed_in?).to be false
      end
    end
  end

end 