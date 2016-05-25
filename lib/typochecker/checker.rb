require 'octokit'

module Typochecker

  class Checker
    attr_accessor :scope
    Octokit.default_media_type = "application/vnd.github.v3.text-match+json"

    def initialize(options = { access_token: ENV['GITHUB_TOKEN'] })
      @client = Octokit::Client.new options
    end

    def check(scope, query=[])
      self.scope = scope
      do_check query
    end

    def check_random()
      self.scope = random_repo
      do_check "test"
    end

    private
    def random_repo()
      index = rand 30
      puts index
      repos = @client.search_repos "stars:>10000 sort:updated"
      return nil unless repos && repos[:items].size > 0
      return "repo:#{repos[:items][index][:full_name]}"
    end

    def do_check(query)
      matched = []
      json = @client.search_code "#{query} #{scope}"
      json[:items].each do |item|
        item[:text_matches].each do |match|
          match.each { |k, v| puts "#{k}: #{v}" if k == :fragment || k == :matches }
          matched << match
        end
      end
      matched
    end

  end

end
