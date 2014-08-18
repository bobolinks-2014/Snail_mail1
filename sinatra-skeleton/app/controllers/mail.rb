require ''

GET '/users/:email_address/emails' do
 email = params[:email_address]
 mail = Parser.parse_mail("http://dbc-mail.herokuapp.com/api/bob@example.com/messages?api_token=c88985db0194c65db233ab492de685b8") #returns the id, subject, from_email, and body of the email
p Net::HTTPResponse

content_type :json
mail.to_json
end


# wasborn@ahab.com
