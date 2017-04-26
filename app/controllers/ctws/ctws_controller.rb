require_dependency "ctws/application_controller"

module Ctws
  class CtwsController < ApplicationController
    include Response
    include ExceptionHandler
    # Generic API stuff here
  end
end