require "thor"
require "typochecker/checker"

module Typochecker
  class CLI < Thor
    desc "check typo", "check typo of github"
    default_command :help

    class_option :scope, type: :string, default: "none", desc: 'Search scope(user or organization', aliases: '-s'
    def check(query)
      checker = Typochecker::Checker.new
      checker.check(options[:scope], query)
    end

    desc "check random", "check random popular repo"
    def lucky()
    	checker = Typochecker::Checker.new
    	checker.check_random
    end

    desc "help", "show usage"
    def help
    	puts "usage go here"
    end
  end

end
