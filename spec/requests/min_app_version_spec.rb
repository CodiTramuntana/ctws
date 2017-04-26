require 'rails_helper'

RSpec.describe 'Ctws::MinAppVersion API', type: :request do
  # initialize test data 
  let!(:min_app_versions) { create_list(:min_app_version, 10) }
  let(:min_app_version_id) { min_app_versions.first.id }

  # Test suite for GET /ctws/v1/min-app-version
  describe 'GET /ctws/v1/min_app_version' do
    # make HTTP get request before each example
    before { get '/ctws/v1/min_app_version' }

    it 'returns min_app_version_platforms' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      #expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
  # Test suite for GET /ctws/v1/min-app-versions
  describe 'GET /ctws/v1/min_app_versions' do
    # make HTTP get request before each example
    before { get '/ctws/v1/min_app_versions' }

    it 'returns min_app_versions' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
  # Test suite for GET /ctws/v1/min_app_versions/:id
  describe 'GET /ctws/v1/min_app_versions/:id' do
    before { get "/ctws/v1/min_app_versions/#{min_app_version_id}" }

    context 'when the record exists' do
      it 'returns the min_app_version' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(min_app_version_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:min_app_version_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Ctws::MinAppVersion with 'id'=100/)
      end
    end
  end
  
  # Test suite for POST /ctws/v1/min_app_versions
  describe 'POST /ctws/v1/min_app_versions' do
    # valid payload
    let(:valid_attributes) { { codename: "Test Version", description: "Lorem ipsum dolor sit amet.", platform: "ios", min_version: "2.0.1", store_uri: "https://store.example.com" } }
    
    context 'when the request is valid' do
      before { post '/ctws/v1/min_app_versions', params: { min_app_version: valid_attributes } }

      it 'creates a min_app_version' do
        expect(json['platform']).to eq('ios')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/ctws/v1/min_app_versions', params: { min_app_version: { codename: "Test Version" } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Description can't be blank, Platform can't be blank, Min version can't be blank, Store uri can't be blank/)
          # .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end
  
  # Test suite for PUT /ctws/v1/min_app_versions/:id
  describe 'PUT /ctws/v1/min_app_versions/:id' do
    let(:valid_attributes) { { codename: "Test Version Edit", min_version: "3.0.0" } }

    context 'when the record exists' do
      before { put "/ctws/v1/min_app_versions/#{min_app_version_id}", params: { min_app_version: valid_attributes } }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
  
  # Test suite for DELETE /ctws/v1/min_app_versions/:id
  describe 'DELETE /ctws/v1/min_app_versions/:id' do
    before { delete "/ctws/v1/min_app_versions/#{min_app_version_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
  
end

# http POST :3000/ws/v1/min_app_versions codename="Test Version" description="Lorem ipsum dolor sit amet." platform="ios" min_version="2.0.1" store_uri="https://store.example.com"
# http PUT :3000/ws/v1/min_app_versions/2 codename="TTest Version Edit" min_version="3.0.0"