class SmsController < ApplicationController
	def sendSMS
		# Get twilio-ruby from twilio.com/docs/ruby/install

		# Get your Account Sid and Auth Token from twilio.com/user/account
		account_sid = 'ACbf9bece037007e2ecf202aa6db78397f'
		auth_token = 'a4c2c22710de0026bcbfa97f31a4e0dc'
		@client = Twilio::REST::Client.new account_sid, auth_token
 
		message = @client.account.messages.create(:body => "MeuMedico.com Informa: Consulta agendada com #{params[:doc_name]} no endereco #{params[:city]}, #{params[:neighborhood]}, #{params[:address]} no dia #{params[:date]} as #{params[:hour]}h.",
    	:from => "+19195513797",
    	:to => params[:sms_form][:tel])

		redirect_to :controller => 'doctors', :action => 'doctorDetails', :doctor => params[:doc]
	end
end
