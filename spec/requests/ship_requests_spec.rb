require 'rails_helper'

RSpec.describe "ShipRequests", type: :request do
  describe "GET /ship_requests" do
    it "works! (now write some real specs)" do
      get ship_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
