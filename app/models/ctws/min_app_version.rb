module Ctws
  class MinAppVersion < ApplicationRecord
    validates_presence_of :codename, :description, :platform, :min_version, :store_uri
  end
end
