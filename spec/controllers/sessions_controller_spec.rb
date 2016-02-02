require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user)                { FactoryGirl.create(:user) }
  let(:valid_credentials)   { { email: user.email, password: 'password' } }
  let(:invalid_credentials) { { email: user.email, password: 'wrongpassword' } }
  let(:valid_session)       { {} }


  describe 'POST #create' do
    context 'when the credentials are correct' do

      before(:each) do
        post :create, { session: valid_credentials }
        user.reload
      end

      it 'returns the user record corresponding to the given credentials' do
        expect(json_response[:user][:auth_token]).to eql user.auth_token
      end

      it 'responds with http status code 200 / ok' do
        expect(response).to have_http_status(:ok)
      end
    end


    context 'when the credentials are incorrect' do

      before(:each) do
        post :create, { session: invalid_credentials }
      end

      it 'returns a json with an error' do
        expect(json_response[:errors]).to eql 'Invalid email or password'
      end

      it 'responds with http status code 422 / unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end


  describe 'DELETE #destroy' do

    before(:each) do
      user = FactoryGirl.create :user
      delete :destroy, { id: user.auth_token }
    end

    it 'responds with http status code 204 / no content' do
      expect(response).to have_http_status(204)
    end

  end

end
