module Ctws
  class Message
    def self.not_found(record = 'record')
      I18n.t('ctws.not_found', record: record)
    end

    def self.unmatched_route(route = 'route')
      I18n.t('ctws.unmatched_route', route: route)
    end

    def self.invalid_credentials
      I18n.t('ctws.invalid_credentials')
    end

    def self.invalid_token
      I18n.t('ctws.invalid_token')
    end

    def self.missing_token
      I18n.t('ctws.missing_token')
    end

    def self.unauthorized
      I18n.t('ctws.unauthorized')
    end

    def self.resource_created(resource)
      I18n.t('ctws.resource_created', resource: resource)
    end

    def self.resource_updated(resource)
      I18n.t('ctws.resource_updated', resource: resource)
    end

    def self.resource_not_created(resource)
      I18n.t('ctws.resource_not_created', resource: resource)
    end

    def self.resource_doesnt_exist(resource)
      I18n.t('ctws.resource_doesnt_exist', resource: resource)
    end

    def self.authenticated_user_success
      I18n.t('ctws.authenticated_user_success')
    end

    def self.expired_token
      I18n.t('ctws.expired_token')
    end

    def self.record_not_confirmed(record = 'record')
      I18n.t('ctws.record_not_confirmed', record: record)
    end

    def self.signature_verification_raised
      I18n.t('ctws.signature_verification_raised')
    end
  end
end
