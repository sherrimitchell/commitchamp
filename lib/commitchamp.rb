$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pry'

require 'commitchamp/version'
require 'commitchamp/init_db'
require 'commitchamp/github'

module Commitchamp
  class App
    def initialize
      @github = Github.new
      @user = nil
      @repo = nil
      @contribution = nil
    end

      def get_member_list(org_id)
      members = self.get_members(org_id)
      member = members.find { |x| x['name'] == member_name }
      self.get_members(member['login'])
    end

    def get_member_counts(owner_id, repo_id)
      contributions = self.get_contributors(owner_id, repo_id, page=1)
      user_adds = contributions.find { |x| x['adds'] == additions }
      user_dels = contributions.find { |x| x['dels'] == deletions}
      user_coms = contributions.find { |x| x['coms'] == commits}
    end

  end
end

# app = Commitchamp::App.new
# binding.pry



# Normal Mode
# Prompt the user for a github organization to report on
# Produce a table of contributions
# Get the list of all members in that organization, 
# and then aggregate the addition, deletion and change 
# counts (as returned from the contributors endpoint) 
# for all public repositories for each user (note: not just contributions 
  # to repos for the organization).

# The script should produce a table something like

#               Additions     Deletions     Changes
# User 1            13534          2954        6249
# User 2             6940           913        1603
# ...