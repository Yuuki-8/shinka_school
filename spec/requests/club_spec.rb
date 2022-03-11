require 'rails_helper'

RSpec.describe "Clubs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/club/index"
      expect(response).to have_http_status(:success)
    end
  end

end
