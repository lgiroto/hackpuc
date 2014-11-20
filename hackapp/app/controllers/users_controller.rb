class UsersController < ApplicationController
	def register
	end

	def new
		@user = User.new(user_params)
	  	@user.save
	end

	private
		def user_params
			params.require(:user_form).permit(:name, :email, :password)
		end
end
