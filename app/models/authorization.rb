class Authorization < ActiveRecord::Base
  attr_accessible :expires_at, :provider, :uid, :user_id, :oauth_token

  belongs_to :user

end
