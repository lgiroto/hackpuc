class UsersController < ApplicationController
	def register
	end

	def new
		@user = User.new(user_params)
	  	@user.save
      	# UserNotifier.send_signup_email(@user).deliver
		
		log_in @user
        @user_info = @user
	end

	  def showAll
	    @allusers = User.all
	  end

	private
		def user_params
			params.require(:user_form).permit(:name, :email, :password)
		end
end
