require 'rails_helper'

module Ctws
  RSpec.describe 'Ctws::User API', type: :request do
    let(:ctws_user) { build(:ctws_user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_attributes) do
      attributes_for(:ctws_user, email: ctws_user.email, password_confirmation: ctws_user.password_confirmation)
    end
    
    # User signup test suite
    # http --form POST :3000/ctws/v1/signup email='hola@agusti.cat', password_confirmation: "123456"
    describe 'POST /ctws/v1/signup' do
      context 'when valid request' do
        before { post '/ctws/v1/signup', params: valid_attributes.to_json, headers: headers }
        
        it 'creates a new user' do
          expect(response).to have_http_status(201)
        end
        
        it 'returns success message' do
          expect(json["data"]["attributes"]["message"]).to match(/Account created successfully/)
        end
        
        it 'returns an authentication token' do
          expect(json["data"]["attributes"]["auth_token"]).not_to be_nil
        end
      end
      
      context 'when invalid request' do
        before { post '/ctws/v1/signup', params: {}, headers: headers }
        
        it 'does not create a new user' do
          expect(response).to have_http_status(422)
        end
        
        it 'returns failure message' do
          expect(json["errors"]['message']).not_to be_nil
        end
      end
    end
  end 
end

# curl -X POST -H 'Content-Type: application/json' -F "email:agusti.br@coditramuntana.com" -F "password: 123456789" http://localhost:3000/ws/v1/signup
# {"success":true,"data":{"message":"Account created successfully","auth_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTQ1MTY3NjR9.CWETXkwdlS8jhhu0RHYbYhcBdkpZw1ySoVMCTGgUL6g"}}%  