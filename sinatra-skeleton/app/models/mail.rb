require 'nokogiri'
require 'open-uri'

class Parser

  def self.parse_mail(url)
    fetched_XML = Nokogiri::XML(open(url))

    array_of_messages = []

    fetched_XML.xpath("//message").each do |message|
      array_of_messages << {
        id: message.search("id").children.text,
        subject: message.search("subject").children.text,
        from: message.search("from").children.text,
        body: message.search("body").children.text
      }
    end

    array_of_messages
  end

end





