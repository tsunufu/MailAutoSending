ActiveRecord::Base.establish_connection

class Contents < ActiveRecord::Base
    belongs_to :groups
end

class Groups < ActiveRecord::Base
    has_many :contents
end