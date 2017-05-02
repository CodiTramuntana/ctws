require 'rails_helper'

module Ctws
  RSpec.describe User, type: :model do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
  end
end
