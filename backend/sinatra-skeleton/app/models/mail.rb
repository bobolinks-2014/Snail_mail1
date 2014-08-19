require 'nokogiri'
require 'net/http'
require 'open-uri'

class Mail

  def self.status(mail_url)
    # uri = URI.parse(mail_url)
    @res = Net::HTTP.get_response(URI.parse(mail_url))
  end

  def self.parse_mail(mail_url)
    fetched_XML = Nokogiri::XML(open(mail_url))
    # uri = URI.parse(mail_url)
    # res = Net::HTTP.get_response(uri).code

    array_of_messages = []

    fetched_XML.xpath("//message").each do |message|
      array_of_messages << {
        time_received: message.search("created-at").text,
        subject: message.search("subject").text,
        from: message.search("from").text,
        body: message.search("body").text
      }
    end
    array_of_messages
  end

  def self.new_mail?(mail_count_url)
    fetched_count = Nokogiri::XML(open(mail_count_url))
    fetched_count.xpath("//count").text.to_i > 0
  end

end






