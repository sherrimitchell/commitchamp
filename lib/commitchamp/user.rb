module Commitchamp
  class User < ActiveRecord::Base
    belongs_to :org
    has_many :contributions
    has_many :repos, through: :contributions
  end
end