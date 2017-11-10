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

    def self.account_created
      I18n.t('ctws.account_created')
    end

    def self.account_not_created
      I18n.t('ctws.account_not_created')
    end

    def self.account_doesnt_exist
      I18n.t('ctws.account_doesnt_exist')
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
  end
end
