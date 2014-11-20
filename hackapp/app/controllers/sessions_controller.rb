class SessionsController < ApplicationController

  def new
  end

  def create
  	if params[:session][:user_type] == "user"
	    user = User.find_by(email: params[:session][:email].downcase)
	    if user && user.authenticate(params[:session][:password])
    		session[:user_type] = 'user'
	    	log_in user
	        @user_info = user
	      	redirect_to root_path
	    else
	      flash.now[:danger] = "Erro: Email ou senha invalida!"
	      render 'new'
	    end
	else
	    user = Doctor.find_by(email: params[:session][:email].downcase)
	    if user && user.authenticate(params[:session][:password])
    		session[:user_type] = 'doctor'
	    	log_in user
	        @user_info = user
	      	redirect_to root_path
	    else
	      flash.now[:danger] = "Erro: Email ou senha invalida!"
	      render 'new'
	    end
	end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end