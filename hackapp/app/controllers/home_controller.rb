class HomeController < ApplicationController
  def index
  	@texto = 3
  end

  def quatro
  	@texto = 4.0
  	render "index"
  end

  def new
	@user = User.new(user_params)
  	@texto = @user.name
  	@user.save
  	redirect_to home_showAll_path
  end

  def showAll
	@allusers = User.all
  end

  def user_params
    params.require(:user_form).permit(:name, :email, :password)
  end
end
