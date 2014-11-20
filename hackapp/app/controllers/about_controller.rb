class AboutController < ApplicationController
  	def index
  		@validate = Hash.new
  		@validate[:name] = 0
  		@validate[:email] = 0
  		@validate[:message] = 0
  	end

  	def sendMessage
  		@validate = Hash.new
  		@message = params[:message_form]


 		if @message[:name].blank?
 			@validate[:name] = 1
  		end
		
  		if @message[:email].blank?
  			@validate[:email] = 1
  		end

  		if @message[:message].blank?
  			@validate[:message] = 1
  		end

  		if @message[:name].blank? || @message[:message].blank? || @message[:email].blank?
  			render "index" 
		end

 		#AboutNotifier.send_about_email(@message).deliver
	end

end
