require 'rails_helper'

RSpec.describe 'Users', type: :request do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    set_http_auth_header!(user.auth_token)
  end

  # describe 'GET /users' do
  #   it 'works! (now write some real specs)' do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
end
