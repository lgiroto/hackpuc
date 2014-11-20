class AboutController < ApplicationController
  def index

  end

  def sendMessage
 	@message = params[:message_form]
 	#AboutNotifier.send_about_email(@message).deliver
 	render "index"
  end

end
