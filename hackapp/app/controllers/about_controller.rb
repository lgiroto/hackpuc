class AboutController < ApplicationController
  def index
  	#@message = {{"name",0},{"email",0},{"subject",0},{"message",0}}
  	#@message.name = 0
  	#@message.email = 0
  	#@message.subject = 0
  	#@message.message = 0

  end

  def sendMessage
 	@message = params[:message_form]
 	render "index"
  end

end
