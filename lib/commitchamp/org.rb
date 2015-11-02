module Commitchamp
  class Org < ActiveRecord::Base
    has_many :repos
    has_many :users
  end
end