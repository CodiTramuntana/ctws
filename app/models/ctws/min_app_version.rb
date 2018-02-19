module Ctws
  class MinAppVersion < ApplicationRecord
    validates_presence_of :codename, :description, :platform, :min_version, :store_uri

    def as_jsonapi(options={})
      {
        type: ActiveModel::Naming.param_key(self),
        id: self.id,
        attributes: {
          codename: self.codename,
          description: self.description,
          min_version: self.min_version,
          platform: self.platform,
          store_uri: self.store_uri,
          updated_at: self.updated_at
        }
      }
    end
  end
end
