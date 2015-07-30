require 'terminal-table'
require 'data_table'

module Sisense
  class Dashboard
    def initialize(obj)
      @obj = obj
    end

    def title
      @obj['title']
    end

    def id
      @obj['oid']
    end

    def to_s
      "#{title} - #{id}"
    end
  end

  module DashboardTable
    extend DataTable
    extend self

    def header
      [
        "Id",
        "Title"
      ]
    end

    def to_row(dashboard)
      return [
        dashboard.id,
        dashboard.title,
      ]
    end
  end

  module Dashboards
    extend self

    def list(connection)
      connection.get('/dashboards').map { |dash| Dashboard.new(dash) }
    end
  end

end