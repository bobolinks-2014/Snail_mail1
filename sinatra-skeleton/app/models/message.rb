class Message < ActiveRecord::Base
  belongs_to :user

  validates :time_received, uniqueness: :true
end
