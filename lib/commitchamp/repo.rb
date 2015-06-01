module Commitchamp
  class Repo < ActiveRecord::Base
    has_many :users, through: :contributions
    end
  end