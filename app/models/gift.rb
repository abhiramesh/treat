class Gift < ActiveRecord::Base
  attr_accessible :amount, :name, :recipient_id, :recipient_phone, :redeemed, :sender_id

  require 'twilio-ruby'

  def send_gift_text
  	account_sid = 'AC32cf1bcc62dad5317ce6b8bfd9b44c12'
  	auth_token = 'b1b7dd639c30cc4dca08c7ca712784b5'

  	sender_name = User.find(self.sender_id).name
  	client = Twilio::REST::Client.new(account_sid, auth_token)

  	client.messages.create(
	  :from => '+14045864607',
	  :to => "#{self.recipient_phone}",
	  :body => "Sup! You just got $#{self.amount} in drinks from #{sender_name}. Download the Treat App here to redeem it!",
	)
  end


end
