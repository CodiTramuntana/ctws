module Ctws
  module Response
    # responds with JSON and an HTTP status code (200 by default)
    # json_response(@todo, :created)
    def payload? object, status
      case status
      when :not_found, :unprocessable_entity, :unauthorized, :invalid_token
        self.errors_payload(object)
      else
        self.data_payload(object)
      end
    end

    def json_response(object = {}, status = :ok)
      render json: self.payload?(object, status), status: status
    end

    def data_payload(object)
      {data: object}
    end
    def errors_payload(object)
      {errors: object}
    end
  end
end