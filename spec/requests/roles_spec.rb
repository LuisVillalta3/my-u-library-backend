require 'rails_helper'

RSpec.describe "Roles", type: :request do
  let!(:roles) { create_list(:role, 2) }
  describe "GET /api/v1/roles" do
    before { get '/api/v1/roles' }
    it 'should return all roles' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
