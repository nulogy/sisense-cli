require 'sisense/run_on_include'

module Sisense
  module Commands
    module Elasticube
      extend RunOnInclude

      included do
        desc 'Manage Sisense Elasticubes'
        arg_name 'Describe arguments to elasticube here'
        command :elasticube do |c|
          c.action do |global_options,options,args|
            puts "elasticube command ran"
          end
        end
      end

    end
  end
end
