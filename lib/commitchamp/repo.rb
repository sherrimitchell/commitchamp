module Commitchamp
  class Repo < ActiveRecord::Base
    belongs_to :org
    has_many :contributions
    has_many :users, through: :contributions
    end
  end