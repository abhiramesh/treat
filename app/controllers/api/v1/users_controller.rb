class Api::V1::UsersController < ApplicationController

	def login
		if params["oauth_token"]
			graph = Koala::Facebook::API.new(params["oauth_token"])
			if graph 
				me = graph.get_object("me")
				user = User.find_by_email(me["email"])
				if user
					auth = user.authorizations.find_by_provider("facebook")
					if auth
						sign_in user
						auth.oauth_token = params["oauth_token"]
						user.save
						auth.save
						render json: {auth_token: user.auth_token, email: user.email}
					else
						render json: {status: ["Invalid login information"]}
					end
				else
					uid = me["id"]
					name = me["name"]
					email = me["email"]	
					new_user = User.create(email: email, password: Devise.friendly_token, name: name)
					if new_user.save
						auth = Authorization.create(user_id: new_user.id, provider: "facebook", oauth_token: params["oauth_token"], uid: uid)
						sign_in new_user
						render json: {auth_token: new_user.auth_token, email: new_user.email}
					else
						render :json => {:status => new_user.errors.full_messages}
					end
				end
			end
		else
			render json: {status: ["Invalid login information"]}
		end
	end

end
