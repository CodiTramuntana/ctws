require 'rails_helper'

module Ctws
  RSpec.describe 'Ctws::User API', type: :request do
    let(:ctws_user) { build(:ctws_user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_attributes) do
      attributes_for(:ctws_user, email: ctws_user.email, password_confirmation: ctws_user.password_confirmation)
    end
    
    # User signup test suite
    describe 'POST /ctws/v1/signup' do
      context 'when valid request' do
        before { post '/ctws/v1/signup', params: valid_attributes.to_json, headers: headers }
        
        it 'creates a new user' do
          expect(response).to have_http_status(201)
        end
        
        it 'returns success message' do
          expect(json["data"]['message']).to match(/Account created successfully/)
        end
        
        it 'returns an authentication token' do
          expect(json["data"]['auth_token']).not_to be_nil
        end
      end
      
      context 'when invalid request' do
        before { post '/ctws/v1/signup', params: {}, headers: headers }
        
        it 'does not create a new user' do
          expect(response).to have_http_status(422)
        end
        
        it 'returns failure message' do
          expect(json["data"]['message'])
          .to match(/Validation failed: Password can't be blank, Email can't be blank, Password digest can't be blank/)
        end
      end
    end
  end 
end

