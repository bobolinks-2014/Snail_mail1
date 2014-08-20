class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :folder

  validates :time_received, uniqueness: :true

end
