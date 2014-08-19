require 'open-uri'

require 'net/http'

email= 'bob@example.com'

response = Net::HTTP.get_response(URI.parse("http://dbc-mail.herokuapp.com/api/#{email}/messages?api_token=c88985db0194c65db233ab492de685b8"))
  p response

