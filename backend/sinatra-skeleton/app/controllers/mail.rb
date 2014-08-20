require 'net/http'
require 'nokogiri'
require 'open-uri'


before "*" do
   headers 'Access-Control-Allow-Origin' => '*',
           'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
end


get '/users/:email_address/emails' do
  user = User.find_or_create_by(email: params[:email_address])
  user.messages.empty? ? last_id = 0 : last_id =  user.messages.last.id + 1
  p last_id
  mail = Mail.new("http://dbc-mail.herokuapp.com/api/#{params[:email_address]}/messages?api_token=c88985db0194c65db233ab492de685b8", "http://dbc-mail.herokuapp.com/api/#{params[:email_address]}/messages/count?last_id=#{last_id}&api_token=9f2c07f74b45aa8b3c5eb901db94190c")

  mail.fire_request

  if mail.request_status == "200"
    if mail.new_mail?
      parsed_mail = mail.parse_mail
      user.build_inbox(parsed_mail)
    else
      "No new mail"
    end
  else
    "status error"
  end

  content_type :json
  user.messages.order(time_received: :desc).limit(200).to_json
end

get '/users/:email_address/trash/:id' do
  Message.find(params[:id]).destroy
end

get '/users/:email_address/folders' do
  folders = Folder.all

  content_type :json
  folders.to_json
end

post 'users/:email_address/folder/new' do
  p params
end


