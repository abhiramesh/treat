class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :auth_token

  has_many :authorizations, dependent: :destroy

  before_save :ensure_auth_token

  def ensure_auth_token
    if auth_token.blank?
      self.auth_token = generate_auth_token
    end
  end


  def generate_auth_token
    loop do
      token = SecureRandom.hex
      break token unless User.where(auth_token: token).first
    end
  end

  def sent_gifts
    Gift.where(sender_id: self.id)
  end

  def received_gifts
    Gift.where(recipient_id: self.id)
  end

end
