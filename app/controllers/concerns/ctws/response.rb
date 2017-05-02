module Ctws
  module Response
    # responds with JSON and an HTTP status code (200 by default)
    # json_response(@todo, :created)
    def success? status
      case status
      when :not_found, :unprocessable_entity, :unauthorized, :invalid_token
        false
      else
        true
      end
    end
    def json_response(object, status = :ok)
      responds = {
        success: self.success?(status),
        data: object
      }
      render json: responds, status: status
    end
  end
end