require "httparty"
url = "https://sendgrid.com/api/mail.send.json"

response = HTTParty.post url, :body => {
  "api_user" => "roberto.bandeira",
  "api_key" => "beto1107",
  "to" => @email, 
  "from" => "beto_bmms@hotmail.com",
  "subject" => "Confirmação de conta",
  "text" => "Prezado usuário, confirmamos seu registro no MeuMédico.com"
}

response.body