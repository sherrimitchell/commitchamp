
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pry'
require 'httparty'

require 'commitchamp/version'


def initialize
    github = Github.new
    @oauth_token = ENV['OAUTH_TOKEN']
    @user = nil
    @repo = nil
    @contribution = nil
  end

def run
      user
      organization = prompt("What organization would you like to report on?", /^\w+$/)
      @github.get_members(org_id)
      user_names = self.get_member_list
      User.create(user_names)
      user_contributions = self.get_member_counts
      Contributions.create(user_contributions)
    end



# Running ruby github-stats.rb should:

# Prompt the user for an auth token (falling back public if none given)
# Prompt the user for an auth token if ENV['OAUTH_TOKEN'] is nil
# Prompt the user for a github organization to report on
# Produce a table of contributions

# Normal Mode

# Get the list of all members in that organization, and then aggregate the addition, deletion and change counts (as returned from the contributors endpoint) for all public repositories for each user (note: not just contributions to repos for the organization).

# The script should produce a table something like

#               Additions     Deletions     Changes
# User 1            13534          2954        6249
# User 2             6940           913        1603
# ...

