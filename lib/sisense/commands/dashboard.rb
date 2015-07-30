require 'sisense/run_on_include'

module Sisense
  module Commands
    module Dashboard
      extend RunOnInclude

      included do
        desc 'Manage Sisense Dashboards'
        arg_name 'Describe arguments to dashboard here'
        command :dashboard do |c|

          c.desc 'Prints existing sisense configuration'
          c.command :list do |subcommand|
            subcommand.action do |global_options,options,args|
              @connection = Sisense::Connection.new(@config)
              dashboards = Sisense::Dashboards.list(@connection)
              puts DashboardTable.format(dashboards)
            end
          end

        end
      end

    end
  end
end
