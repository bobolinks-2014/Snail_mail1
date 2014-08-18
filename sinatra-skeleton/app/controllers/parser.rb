require 'net/http'
require 'nokogiri'
require 'open-uri'

get '/users/:email_address/emails' do
  email = params[:email_address]
  url = "http://dbc-mail.herokuapp.com/api/#{email}/messages?api_token=c88985db0194c65db233ab492de685b8"
# uri = URI.parse(url)
# p uri
# p uri.host
# p uri.port
# p uri.path
# p Net::HTTP.get_response(uri).code
# result = Net::HTTP.start(uri.host, uri.port) { |http| http.get(uri.path) }
# puts result.code
# puts result.body
  status = Parser.status(url)
  mail = Parser.parse_mail(url) #returns the id, subject, from_email, and body of the email
# p status
# content_type :json
# mail.to_json
  mail.each do |message|
    puts "*"*100
    p Messages.create(message)
    puts "*"*100
  end
end

