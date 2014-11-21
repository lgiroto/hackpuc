class AboutController < ApplicationController
  	def index
  		@validate = Hash.new
  		@validate[:name] = 0
  		@validate[:email] = 0
  		@validate[:message] = 0
  	end

  	def sendMessage
#    @temp = []
    @validate = Hash.new 
 		@message = params[:message_form]
#     @temp = []
#    @temp = params.map[:name]

 #   @validate = Hash["name", @temp[0], "email", @temp[1], "subject", @temp[2], "message", @temp[3]];

  #  if @validate[:name] == true
  #    render "index"
  #  end

#    @validate.each do |k,v|
 #     if v == true
  #      render "index"
   #   end
    #end

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
