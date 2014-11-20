class AboutNotifier < ActionMailer::Base
  default to: "mauriciopsgv@gmail.com"
	

	def send_about_email(message)
		@message = message
		mail(from: @message[:email], subject: @message[:subject])
	end

end
