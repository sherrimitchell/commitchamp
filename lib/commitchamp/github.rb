require 'httparty'

module Commitchamp
  class Github
    include HTTParty
    base_uri "https://api.github.com"
   
    def initialize(auth_token=nil)
     token = ENV[OAUTH_TOKEN]
     unless token
      token = prompt("Please enter your Github personal access token: ", /^[0-9a-f]{40}$/)
      end
      @headers = {
        "Authorization" => "token #{auth_token}", 
      "User-Agent" => "HTTParty"}
    end

    def get_repo_contributors(owner, repo)
      self.class.get(
      "/repos/#{owner}/#{repo}/stats/contributors", headers: @headers)
    end

    def get_repo_info(owner, repo)
      response = self.get_repo_contributors(owner, repo)
      response.map { |contribution| get_user_info(contribution) }
      end

    def get_user_info(contribution)
      user = get_author(contribution)
      additions = get_stats(contribution, a)
      deletions = get_stats(contribution, d)
      changes = get_stats(contribution, c)
      { user => [additions, deletions, changes] }
    end

    
    private
    def get_author
      contribution["author"]["login"]
    end

    def get_stats(contribution, stat)
      weeks = contribution["weeks"]
      weeks.inject(0) { |sum, item| sum + item[stat] }
    end

    def prompt(message, validator)
      puts message
      input = gets.chomp
      until input =~ validator
        puts "I'm sorry. I didn't understand that answer."
        puts message
        input = gets.chomp
      end
      input
    end
  end
end