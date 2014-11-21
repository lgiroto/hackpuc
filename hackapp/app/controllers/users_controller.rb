class UsersController < ApplicationController
	def register
		@erro = false
		@validate = Hash.new
  		@validate[:name] = 0
  		@validate[:email] = 0
  		@validate[:message] = 0

  	
	end

	def new

		@validate = Hash.new
		@temp = params[:user_form]

		if @temp[:name].blank?
 			@validate[:name] = 1
		end
	
 		if @temp[:password].blank?
			@validate[:password] = 1
		end

		if @temp[:email].blank?
			@validate[:email] = 1
		end

		if @temp[:name].blank? || @temp[:password].blank? || @temp[:email].blank?
			render "register" 
   		else


			user_search = User.find_by(email: params[:user_form][:email])
			if user_search.nil?
			@user = User.new(user_params)

		 	 	@user.save
      	# UserNotifier.send_signup_email(@user).deliver
       			@erro = false
      			session[:user_type] = 'user'
				log_in @user
       			@user_info = @user
       		else
       			@validate[:email] = 2
       		#flash.now[:danger] = "Erro: Email já cadastrado!"
       			@erro = true
       			render 'register'
       		end
       	end
	end

	  def showAll
	    @allusers = User.all
	  end

	private
		def user_params
			params.require(:user_form).permit(:name, :email, :password)
		end

	def user_sched
		@user_sched_search = Schedules.find_by(@current_user.id)
	end
end
