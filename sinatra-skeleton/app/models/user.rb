class User < ActiveRecord::Base
  has_may :messages
end
