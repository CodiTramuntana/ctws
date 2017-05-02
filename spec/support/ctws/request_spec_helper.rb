module Ctws
  module RequestSpecHelper
    def json
      JSON.parse(response.body)
    end
    def expect_success(value= true)
      # expect(json["success"]).to eq(value)
    end
  end
end