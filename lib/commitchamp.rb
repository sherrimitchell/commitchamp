$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pry'

require 'commitchamp/version'
require 'commitchamp/init_db'
require 'commitchamp/github'

module Commitchamp
  class App
    def initialize
      if ENV['OAUTH_TOKEN']
        token = ENV['OAUTH_TOKEN']
      else
        token = get_auth_token
      end
      @github = Github.new(token)
    end

    def prompt(question, validator)
      puts question
      input = gets.chomp
      until input =~ validator
        puts "I'm sorry. I didn't understand that answer."
        puts question
        input = gets.chomp
      end
      input
    end

    def get_auth_token
      prompt("Please enter your Github personal access token: ", /^[0-9a-f]{40}$/)
    end

    def get_org_info
      prompt("Please enter the name of the organization that you would like to see a report for: " )
      gets.chomp = "#{owner_id}"
    end

    def get__owner_info
      prompt("Please enter the repo owner:" )
      gets.chomp = "#{repo_id}"
    end

  # binding.pry

    def get_contributor_info(repo_id, owner_id)
      repo = Repo.first_or_create(repo_name: repo_id)
      results = @github.get_contributions(owner_id, repo_id, page=1)
      contributions = self.get_contributors("#{owner_id}", "#{repo_id}")

      results.each do |contributor|
        user = User.first_or_create(name: contributor['author']['login'])
        user_adds = contributor['weeks'].map { |x| x['a'] }.sum
        user_dels = contributor['weeks'].map { |x| x['d'] }.sum
        user_coms = contributor['weeks'].map { |x| x['c'] }.sum
      end

        user.contributions.create(additions: user_adds, deletions: user_dels,
          changes: user_coms,
          repo_name: repo_id)
      end

    def display_table_header
      puts "Additions.rjust(26)  Deletions.rjust(40) Changes.rjust(44)"
    end

    def print_contributor_data
      self.display_table_header
      user = User.find_each(additions: user_adds, deletions: user_dels, changes: user_coms, repo_name: repo_id)

      user.each.map { |user| puts user }
    end

  end
end


app = Commitchamp::App.new
binding.pry
