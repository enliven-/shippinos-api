require 'rails_helper'


RSpec.describe UsersController, type: :controller do

  let(:valid_attributes)    { FactoryGirl.attributes_for(:user) }
  let(:invalid_attributes)  { FactoryGirl.attributes_for(:invalid_user) }
  let(:user)                { FactoryGirl.create(:user) }
  let(:manager)             { FactoryGirl.create(:manager) }
  let(:admin)               { FactoryGirl.create(:admin) }

  let(:valid_session)       { {} }



  describe 'GET #index' do

    it 'is forbidden for regular user' do
      set_http_auth_header!(user.auth_token)
      get :index, {}, valid_session

      expect(response).to have_http_status(:forbidden)
    end

    it 'is accessible to manager' do
      set_http_auth_header!(manager.auth_token)
      get :index, {}, valid_session

      expect(response).to have_http_status(:ok)
    end

    it 'is accessible to admin' do
      set_http_auth_header!(admin.auth_token)
      get :index, {}, valid_session

      expect(response).to have_http_status(:ok)
    end

    it 'returns users as array' do
      set_http_auth_header!(admin.auth_token)
      user    = FactoryGirl.create(:user)
      manager = FactoryGirl.create(:manager)
      get :index, {}, valid_session

      expect(json_response[:users].length).to eql(3)
    end
  end



  describe 'GET #show' do

    it 'gets user response as a hash' do
      set_http_auth_header!(manager.auth_token)
      get :show, {:id => user.id}, valid_session

      expect(json_response[:user][:email]).to eq(user.email)
    end

    it 'is accessible to user for himself' do
      set_http_auth_header!(user.auth_token)
      get :show, {:id => user.id}, valid_session

      expect(json_response[:user][:email]).to eq(user.email)
    end

    it 'is forbidden to user for other users' do
      set_http_auth_header!(user.auth_token)
      get :show, {:id => manager.id}, valid_session

      expect(response).to have_http_status(:forbidden)
    end

    it 'is accessible to manager for all users' do
      set_http_auth_header!(manager.auth_token)
      get :show, {:id => admin.id}, valid_session

      expect(json_response[:user][:email]).to eq(admin.email)
    end

    it 'is accessible to admin for all users' do
      set_http_auth_header!(admin.auth_token)
      get :show, {:id => manager.id}, valid_session

      expect(json_response[:user][:email]).to eq(manager.email)
    end

  end



  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'returns errors hash' do
        post :create, {:user => invalid_attributes}, valid_session

        expect(json_response[:errors][:email]).to include('is invalid')
      end
    end
  end



  describe 'PUT #update' do
    let(:new_attributes) { { email: 'someone@else.com' } }

    context 'with valid params' do
      it 'updates the requested user' do
        set_http_auth_header!(manager.auth_token)
        put :update, {:id => user.to_param, :user => new_attributes}, valid_session
        user.reload

        expect(user.email).to eq('someone@else.com')
      end
    end

    context 'with invalid params' do
      it 'returns errors hash' do
        set_http_auth_header!(manager.auth_token)
        put :update, {:id => user.to_param, :user => invalid_attributes}, valid_session

        expect(json_response[:errors][:email]).to include('is invalid')
      end
    end

    it 'is accessible to user for himself' do
      set_http_auth_header!(user.auth_token)
      put :update, {id: user.id, user: new_attributes}, valid_session
      user.reload

      expect(json_response[:user][:email]).to eq(user.email)
    end

    it 'is forbidden to user for other users' do
      set_http_auth_header!(user.auth_token)
      put :update, {id: manager.id, user: new_attributes}, valid_session
      manager.reload

      expect(response).to have_http_status(:forbidden)
    end

    it 'is accessible to manager for all users' do
      set_http_auth_header!(manager.auth_token)
      put :update, {id: admin.id, user: new_attributes}, valid_session
      admin.reload

      expect(json_response[:user][:email]).to eq(admin.email)
    end

    it 'is accessible to admin for all users' do
      set_http_auth_header!(admin.auth_token)
      put :update, {id: manager.id, user: new_attributes}, valid_session
      manager.reload

      expect(json_response[:user][:email]).to eq(manager.email)
    end
  end



  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = FactoryGirl.create(:user)
      set_http_auth_header!(admin.auth_token)

      expect {
        delete :destroy, {:id => user.id}, valid_session
      }.to change(User, :count).by(-1)
    end

    it 'gives a success response with no content' do
      user = FactoryGirl.create(:user)
      set_http_auth_header!(admin.auth_token)
      delete :destroy, {:id => user.id}, valid_session

      expect(response).to have_http_status(204)
    end

    it 'is accessible to user for himself' do
      set_http_auth_header!(user.auth_token)
      delete :destroy, {id: user.id}, valid_session

      expect(response).to have_http_status(204)
    end

    it 'is forbidden to user for other users' do
      set_http_auth_header!(user.auth_token)
      delete :destroy, {id: manager.id}, valid_session

      expect(response).to have_http_status(:forbidden)
    end

    it 'is accessible to manager for all users' do
      set_http_auth_header!(manager.auth_token)
      delete :destroy, {id: admin.id}, valid_session

      expect(response).to have_http_status(204)
    end

    it 'is accessible to admin for all users' do
      set_http_auth_header!(admin.auth_token)
      delete :destroy, {id: manager.id}, valid_session

      expect(response).to have_http_status(204)
    end

  end

end
