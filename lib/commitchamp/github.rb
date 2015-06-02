require 'httparty'

module Commitchamp
  class Github
    include HTTParty
    base_uri "https://api.github.com"
   
    def initialize
      @headers = headers(h = {"Authorization" => "Token #{@oauth_token}", "User-Agent" => "HTTParty"})
    end

    def get_contributions(owner_id, repo_id, page=1)
      params = { query: { page: page } }
      options = {
        headers: @headers,
        query: params
      }
    
    self.class.get("/repos/#{owner}/#{repo}/stats/contributors", options)
    end

  end
end