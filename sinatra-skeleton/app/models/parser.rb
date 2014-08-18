require 'nokogiri'
require 'net/http'
require 'open-uri'

class Parser

  def self.status(url)
    uri = URI.parse(url)
    res = Net::HTTP.get_response(uri).code
  end

  def self.parse_mail(url)
    fetched_XML = Nokogiri::XML(open(url))

    array_of_messages = []

    fetched_XML.xpath("//message").each do |message|
      array_of_messages << {
        time_recieved: message.search("created-at").children.text,
        subject: message.search("subject").children.text,
        from: message.search("from").children.text,
        body: message.search("body").children.text
      }
    end

    array_of_messages
  end



end

# p Parser.parse_mail("http://dbc-mail.herokuapp.com/api/bob@example.com/messages?api_token=c88985db0194c65db233ab492de685b8")




