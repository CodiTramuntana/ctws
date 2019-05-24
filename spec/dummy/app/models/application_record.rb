Rails.application.config.active_record.sqlite3.represent_boolean_as_integer = true
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
