module Commitchamp
  class Repo < ActiveRecord::Base
    belongs_to :org
    has_many :contributions
    has_many :users, through: :contributions
    end

    def get_repos(repo_name)
      repo = Repo.first_or_create(name: repo_name)
      results = @github.get_repo_contributors(owner, repo_name)
      results.each do |contributor|
        user = User.first_or_create(name: contributor['author']['login'])
    end




    private
    def get_repo(org, repo)
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