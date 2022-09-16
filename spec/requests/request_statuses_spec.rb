require 'rails_helper'

RSpec.describe "RequestStatuses", type: :request do
  let!(:request_statuses) { create_list(:request_status, 2) }
  describe "GET /api/v1/request_statuses" do
    before { get '/api/v1/request_statuses' }
    it 'should return all request_statuses' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
