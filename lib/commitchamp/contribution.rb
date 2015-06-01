module Commitchamp
class Contribution < ActiveRecord::Base      
    belongs_to :users
  end
end