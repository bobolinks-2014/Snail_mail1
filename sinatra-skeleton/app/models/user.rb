class User < ActiveRecord::Base
  has_many :messages

  def build_inbox(parsed_mail)
    parsed_mail.each do |message|
      message = Message.create!(message)
      message.update!(user: self)
    end
  end


end
