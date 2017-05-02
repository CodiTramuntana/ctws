require 'rails_helper'

module Ctws
  RSpec.describe MinAppVersion, type: :model do
    it { should validate_presence_of(:codename) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:platform) }
    it { should validate_presence_of(:min_version) }
    it { should validate_presence_of(:store_uri) }
  end
end