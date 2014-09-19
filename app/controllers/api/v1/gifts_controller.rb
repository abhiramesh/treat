class Api::V1::GiftsController < ApplicationController

	before_filter :authenticate_user_from_token!
 	before_filter :authenticate_user!

 	def create
 		if params["name"] && params["phone"] && params["amount"]
 			gift = Gift.create(name: params["name"], sender_id: current_user.id, recipient_phone: params["phone"], amount: params["amount"])
 			gift.send_gift_text
 			render json: {status: ["Gift to successfully created!"]}
 		else
 			render json: {status: ["Insufficient gift information"]}
 		end
 	end

 	def my_sent_gifts
		gifts = current_user.sent_gifts
		render json: gifts, :only => [:id, :name, :amount]
 	end

 	def my_received_gifts
 		gifts = current_user.received_gifts
 		render json: gifts, :only => [:id, :name, :amount]
 	end

end
