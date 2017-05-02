require_dependency "ctws/application_controller"

module Ctws
  class CtwsController < ApplicationController
    include Response
    include ExceptionHandler
    # Generic API stuff here
    
    # called before every action on controllers
    before_action :authorize_request
    attr_reader :current_user

    private

    # Check for valid request token and return user
    def authorize_request
      @current_user = (Ctws::AuthorizeApiRequest.new(request.headers).call)[:user]
    end
  end
end