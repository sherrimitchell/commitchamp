$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pry'

require 'commitchamp/version'
require 'commitchamp/init_db'
require 'commitchamp/github'

module Commitchamp
  class App
    def initialize
      if ENV['OAUTH_TOKEN']
        auth_token = ENV['OAUTH_TOKEN']
      else
        token = get_token
      end
      @github = Github.new 
      @headers = headers(h = {"Authorization" => "Token #{@oauth_token}", "User-Agent" => "HTTParty"})
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

    def confirm?(question)
      answer = prompt(question, /^[yn]$/i)
      answer.upcase == 'Y'
    end

    def get_token
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

        user.contributions.create(additions: user_adds,
          deletions: user_dels,
          changes: user_coms,
          repo_name: repo_id)
      end

    def report_header
      puts "Additions.rjust(16)    Deletions.rjust(32)    Changes.rjust(48)"
    end

    def add_contributor_data(contributors)
    contributors = user.contributions.create(additions: user_adds,
            deletions: user_dels,
            changes: user_coms,
            repo_name: repo_id)
    end

    def print_report(contributors)
      self.report_header
      self.add_contributor.data.each do |contributor|
      end
        puts "#{print_report}"
    end
  end

  end
end

app = Commitchamp::App.new
binding.pry

# def win_game?(board)
#       WINS.any? do |a, b, c|
#         board[a] == board[b] &&  board[b] == board[c]
#       end
#     end
      
#     def draw_game?(board)
#       board.all? { |x| x.is_a? String }
#     end

#     def game_over?(board)
#       win_game?(board) || draw_game?(board)
#     end

# def add_post!(post)
#   puts "Importing post: #{post[:title]}"

#   tag_models = post[:tags].map do |t|
#     Blergers::Tag.find_or_create_by(name: t)
#   end
#   post[:tags] = tag_models

#   post_model = Blergers::Post.create(post)
#   puts "New post! #{post_model}"
# end

# def run!
#   blog_path = '/Users/brit/projects/improvedmeans'
#   toy = Blergers::Importer.new(blog_path)
#   toy.import
#   toy.posts.each do |post|
#     add_post!(post)
#   end
# end


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