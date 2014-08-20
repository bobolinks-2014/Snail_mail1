require 'nokogiri'
require 'net/http'
require 'open-uri'

class Mail
  def initialize(mail_url, mail_count_url)
    @mail_url = mail_url
    @mail_count_url = mail_count_url
  end

  def fire_request
    uri = URI.parse(@mail_url)
    @res = Net::HTTP.get_response(uri)
  end

  def request_status
    @res.code
  end

  def parse_mail
    fetched_XML = Nokogiri::XML(@res.body)

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

  def new_mail?
    fetched_count = Nokogiri::XML(open(@mail_count_url))
    fetched_count.xpath("//count").text.to_i > 0
  end

end






