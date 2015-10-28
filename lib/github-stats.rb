
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pry'
require 'httparty'

require 'commitchamp/version'
require 'commitchamp/init_db'
require 'commitchamp/github'
require 'commitchamp/commitchamp'


def initialize
    github = Github.new
    @user = nil
    @repo = nil
    @contribution = nil
  end

def run
      self.get_auth_token
      self.get_org_info
      self.get_owner_info
      self.get_contributor_info
      self.print_contributor_data
    end

binding.pry