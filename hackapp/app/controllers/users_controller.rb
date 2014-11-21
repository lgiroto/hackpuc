class UsersController < ApplicationController
	def register
		@erro = false
	end

	def new

		user_search = User.find_by(email: params[:user_form][:email])
		if user_search.nil?
		@user = User.new(user_params)

       		@erro = false
	 	 	@user.save
      	# UserNotifier.send_signup_email(@user).deliver
      		session[:user_type] = 'user'
			log_in @user
       		@user_info = @user
       	else

       		@erro = true
       		render 'register'
       	end

	end

	  def showAll
	    @allusers = User.all
	  end

	private
		def user_params
			params.require(:user_form).permit(:name, :email, :password)
		end
end
