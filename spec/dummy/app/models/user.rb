class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :password_digest

  def created_as_jsonapi(options = {})
    {
      type: ActiveModel::Naming.param_key(self),
      id: id,
      attributes: {
        created_at: created_at,
        auth_token: options[:token]
      }
    }
  end
end
