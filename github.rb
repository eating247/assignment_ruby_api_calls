 require 'github_api'

 class Repos

  API_KEY = ENV["GITHUB_API"]

  attr_accessor :github, :repos

  def initialize(username)
    @github = Github.new(oauth_token: API_KEY)
    @repos = @github.repos.list(user: "#{username}", sort: "created", direction: "desc")
    @user = username
  end

  def names
    @repos[0..9].map { |repo| puts repo.name }
  end

  def commits
    @repos[0..9].each do |repo|
      sleep(0.3)
      name = repo.name
      puts puts 
      puts "#Last 10 commits for #{name}:"

      @github.repos.commits.list(@user, name)[0..9].each do |commit|
        puts commit["commit"]["message"]
      end
    end
  end



 end