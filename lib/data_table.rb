module DataTable
  extend self

  def format(rows)
    Terminal::Table.new do |table|
      table << header if respond_to?(:header)
      table.add_separator
      rows.each { |row| table << to_row(row) }
    end
  end

  def to_row(row)
    return []
  end
end