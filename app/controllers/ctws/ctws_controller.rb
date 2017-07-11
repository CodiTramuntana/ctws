require_dependency "ctws/application_controller"

module Ctws
  class CtwsController < ApplicationController
    include Response
    include ExceptionHandler
    # Generic API stuff here
    
    # called before every action on controllers
    before_action :authorize_request
    skip_before_action :authorize_request, only: [:raise_not_found!]
    attr_reader :current_user
    
    def raise_not_found!
      raise Ctws::ExceptionHandler::RoutingError, ("#{Ctws::Message.unmatched_route(params[:unmatched_route])}")
    end
    private

    # Check for valid request token and return user
    def authorize_request
      @current_user = (Ctws::AuthorizeApiRequest.new(request.headers).call)[:user]
    end
  end
end