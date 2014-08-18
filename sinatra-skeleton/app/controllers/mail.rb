require 'net/http'
require 'nokogiri'
require 'open-uri'

get '/users/:email_address/emails' do

  email = params[:email_address]
  user = User.find_or_create_by(email: email)
  mail_url = "http://dbc-mail.herokuapp.com/api/#{email}/messages?api_token=c88985db0194c65db233ab492de685b8"

  status = Mail.status(mail_url)

  if user.messages.size == 0 # put this into a method... mail_objects(mail)
    parsed_mail = Mail.parse_mail(mail_url)
    user.build_inbox(parsed_mail)
  else
    mail_count_url = "http://dbc-mail.herokuapp.com/api/#{email}/messages/count?last_id=#{user.messages.last.id}&api_token=9f2c07f74b45aa8b3c5eb901db94190c"
    if Mail.new_mail?(mail_count_url)
      parsed_mail = Mail.parse_mail(mail_url)
      user.build_inbox(parsed_mail)
    end
  end

  p status

  # user.messages.order(time_received: :desc).limit(200).to_json

   #returns the id, subject, from_email, and body of the email

# Mail.new_mail?(Message.last.id)

# uri = URI.parse(url)
# p uri
# p uri.host
# p uri.port
# p uri.path
# p Net::HTTP.get_response(uri).code
# result = Net::HTTP.start(uri.host, uri.port) { |http| http.get(uri.path) }
# puts result.code
# puts result.body
#   status = Mail.status(url)
#   mail = Mail.parse_mail(url) #returns the id, subject, from_email, and body of the email
# # p status
# # content_type :json
# # mail.to_json
# found_user = User.find_by(email: params[:email_address])
#   mail.each do |message|
#     # puts "*"*100
#     # bob.messages.create(message)
#     message = Message.create(message)
#     message.update(user: found_user)
#     # puts "*"*100
#   end

#   found_user.messages.order(time_received: :desc).limit(200).to_json
end

