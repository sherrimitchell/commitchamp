require 'httparty'

module Commitchamp
  class Github
    include HTTParty
    base_uri "https://api.github.com"
   
    def initialize(access_token)
      @headers = {
        "Authorization" => "token #{access_token}", 
      "User-Agent" => "HTTParty"}
    end

    def get_user_info(username)
      self.class.get(
        "/users/:username", headers: @headers)
    end

    def get_repo_contributors(owner, repo)
      self.class.get(
        "/repos/:owner/:repo/contributors", headers: @headers)
      end

    def get_repo_contributions(owner_id, repo_id)
    self.class.get(
      "/repos/#{owner}/#{repo}/stats/contributors", headers: @headers)
    end

    def get_org_repos(org)
      self.get(
        "/orgs/:org/repos")
    end



  end
end