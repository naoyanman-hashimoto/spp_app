require 'rails_helper'

RSpec.describe "Scores", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/scores/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/scores/create"
      expect(response).to have_http_status(:success)
    end
  end

end
