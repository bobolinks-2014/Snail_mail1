class Folder < ActiveRecord::Base
  has_many :messages

  validates :name, uniqueness: :true
end
