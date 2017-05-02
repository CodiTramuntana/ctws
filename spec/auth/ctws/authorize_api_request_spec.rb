require 'rails_helper'

module Ctws
  RSpec.describe AuthorizeApiRequest, class: 'Ctws::AuthorizeApiRequest' do
    # Create test user
    let(:ctws_user) { create(:ctws_user) }
    
    # Mock `Authorization` header
    let(:header) { { 'Authorization' => token_generator(ctws_user.id) } }
    # Invalid request subject
    subject(:invalid_request_obj) { described_class.new({}) }
    # Valid request subject
    subject(:request_obj) { described_class.new(header) }

    # Test Suite for AuthorizeApiRequest#call
    # This is our entry point into the service class
    describe '#call' do
      # returns user object when request is valid
      context 'when valid request' do
        it 'returns user object' do
          result = request_obj.call
          expect(result[:user]).to eq(ctws_user)
        end
      end

      # returns error message when invalid request
      context 'when invalid request' do
        context 'when missing token' do
          it 'raises a MissingToken error' do
            expect { invalid_request_obj.call }
              .to raise_error(Ctws::ExceptionHandler::MissingToken, 'Missing token')
          end
        end

        context 'when invalid token' do
          subject(:invalid_request_obj) do
            # custom helper method `token_generator`
            described_class.new('Authorization' => token_generator(5))
          end

          it 'raises an InvalidToken error' do
            expect { invalid_request_obj.call }
              .to raise_error(Ctws::ExceptionHandler::InvalidToken, /Invalid token/)
          end
        end

        context 'when token is expired' do
          let(:header) { { 'Authorization' => expired_token_generator(ctws_user.id) } }
          subject(:request_obj) { described_class.new(header) }

          it 'raises ExceptionHandler::ExpiredSignature error' do
            expect { request_obj.call }
              .to raise_error(
                Ctws::ExceptionHandler::ExpiredSignature,
                /Signature has expired/
              )
          end
        end
      end
    end
  end
end