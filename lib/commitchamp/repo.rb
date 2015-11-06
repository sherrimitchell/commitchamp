module Commitchamp
  class Repo < ActiveRecord::Base
    belongs_to :org
    has_many :contributions
    has_many :users, through: :contributions
    end

    def initialize
    	@github = Github.new
    end

    def select_repo
			
    end

    def enter_repo

    end

    def get_repo(owner, repo)
		puts "Would you like to view information for an existing or new repo? Please enter '1' for existing or '2' for new: "
		if input == 1
			self.select_repo
		    	else
		    	self.enter_repo	

    	
    	repo = prompt("Please enter the name of the repo that you would like to view information for:", /^\w+$/)
    	owner = prompt("Please enter the name of the organization that you would like to view information for:", /^\w+$/)
    	
    	@repo = Repo.create(name: repo, owner: owner)
    	results = @github.get_repo_contributors(owner, repo)		
    end

    def list_repo(repo)
    	repo_list = []
    	repos = Repo.find_each(name: repo) do 
    	repos.each do |repo|
    		repo_list.push repo
    	end
    	repo_list
    end

    

    private
    def get_repo(owner, repo)
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