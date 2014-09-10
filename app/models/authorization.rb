class Authorization < ActiveRecord::Base
  attr_accessible :expires_at, :provider, :uid, :user_id

  belongs_to :user
  
end
