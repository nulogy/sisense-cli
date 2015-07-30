require 'sisense/run_on_include'

module Sisense
  module Commands
    module Config
      extend RunOnInclude

      included do

        desc 'Manage sisense configuration'
        command :config do |c|

          c.desc 'Prints existing sisense configuration'
          c.command :show do |subcommand|
            subcommand.action do |global_options,options,args|
              puts @config.pretty
            end
          end

          c.desc 'Create a new configuration for Sisense'
          c.command :new do |subcommand|
            subcommand.action do |global_options,options,args|
              @config = Sisense::ConfigLoader.from_prompt
              ConfigFile.persist(@config)
            end
          end

          c.default_command :show
        end

      end

    end
  end
end
