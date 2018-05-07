require 'json'
require 'csv'
require 'terminal-table'

station_groups = JSON.parse(File.read('stations.json'))
data_rows = CSV.read(ENV['TURNSTILE_FILE'], { return_headers: false })
table = Terminal::Table.new({
  title: "substile",
  headings: ['Name', 'Weekly Pax', 'Daily Pax']
})

station_groups.each_with_index do |station_group, i|
  table.add_separator if i > 0
  station_group.each do |(type, stations)|
    if type == 'heading'
      color = station_group.keys == ['heading'] ? 32 : 34
      table.add_row ["\e[#{color}m#{stations}\e[0m"]
      next
    end

    stations.each do |station|
      data = data_rows
        .select { |r| r[3] == station['name'] && r[4] == station['route'] }
        .group_by { |r| r[2] }
        .map { |(_, rows)| rows.map { |r| r[type == 'in' ? 9 : 10].to_i } }
        .map { |rows| rows[rows.length - 1] - rows[0] }
        .sum

      table.add_row ["#{station['name']} (#{type})", data, (data / 7).round]
    end
  end
end

puts table
