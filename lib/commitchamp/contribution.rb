module Commitchamp
class Contribution < ActiveRecord::Base      
    belongs_to :users
    belongs_to :repo
  end
end