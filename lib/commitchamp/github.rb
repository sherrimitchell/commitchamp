require 'httparty'

module Commitchamp
  class Github
    include HTTParty
    base_uri "https://api.github.com"
   
    def initialize
      @oauth_token = ENV['OAUTH_TOKEN']
      @headers = headers(h = {"Authorization" => "Token #{@oauth_token}", "User-Agent" => "HTTParty"})
    end
    
    # def  get_org(org_id)
    #   self.class.get(@headers, "/orgs/#{org_id}")
    # end

    def get_members(org_id)
      self.class.get("/orgs/#{org_id}/members", headers: @headers)
    end

    def get_contributions(owner_id, repo_id, page=1)
      params = {
        page: page
      }
      options = {
        headers: @headers,
        query: params
      }
    
    self.class.get("/repos/#{owner}/#{repo}/stats/contributors", options)
    end

  end
end 



# a": 68÷98,
#         "d": 77,
#         "c": 10
# Prompt the user for a github organization to report on
# Produce a table of contributions
# Get the list of all members in that organization,
# and then aggregate the addition, deletion and change 
# counts (as returned from the contributors endpoint) 
# for all public repositories for each user (note: not just contributions 
  # to repos for the organization).