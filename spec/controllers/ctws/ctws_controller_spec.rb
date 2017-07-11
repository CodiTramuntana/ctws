require 'rails_helper'

module Ctws
  RSpec.describe CtwsController, type: :controller do
    # create test ctws_user
    let!(:ctws_user) { create(:ctws_user) }
    # set headers for authorization
    let(:headers) { { 'Authorization' => token_generator(ctws_user.id) } }
    let(:invalid_headers) { { 'Authorization' => nil } }
    
    describe "authorize_request" do
      context "when auth token is passed" do
        before { allow(request).to receive(:headers).and_return(headers) }
        
        # private method authorize_request returns current ctws_user
        it "sets the current ctws_user" do
          expect(subject.instance_eval { authorize_request }).to eq(ctws_user)
        end
      end
      
      context "when auth token is not passed" do
        before do
          allow(request).to receive(:headers).and_return(invalid_headers)
        end
        
        it "raises MissingToken error" do
          expect { subject.instance_eval { authorize_request } }.
          to raise_error(Ctws::ExceptionHandler::MissingToken, /Missing token/)
        end
      end
    end
    describe "routes" do
      context "when route is not found" do
        xit "returns 404" do
          to raise_error(Ctws::ExceptionHandler::RoutingError, /No route matches/)
        end
      end
    end
  end
end

