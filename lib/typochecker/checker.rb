require 'octokit'

module Typochecker

  class Checker
    attr_accessor :scope
    Octokit.default_media_type = "application/vnd.github.v3.text-match+json"

    def initialize(options = {})
      @client = Octokit::Client.new options
    end

    def check(scope, words=[])
      self.scope = scope
      do_check words
    end

    private
    def do_check(words)
      matched = []
      json = @client.search_code "#{words} #{scope}"
      json[:items].each do |item|
      	item[:text_matches].each do |match|
      		match.each { |k, v| puts "#{k}: #{v}" }
      		matched << match
      	end
      end
      matched
    end

  end

end
