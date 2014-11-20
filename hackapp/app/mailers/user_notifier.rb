class UserNotifier < ActionMailer::Base
  default :from => 'beto_bmms@hotmail.com'

  def send_signup_email(user)
    @user = user
    mail(to: @user.email, subject: 'Obrigado por se Cadastrar!')
  end
end