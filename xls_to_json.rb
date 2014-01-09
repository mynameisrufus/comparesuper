require 'roo'
require 'json'
require 'pry'

xls = Roo::Excel.new("2013.xls")

heading = xls.sheet(4).row(3)
dates = xls.sheet(4).row(4)
rows = (5..204).map { |row|  xls.sheet(4).row(row) }

funds = rows.map do |row|

  fund = {}

  fund["returns"] = (9..18).map do |n|
    {
      "year" => dates[n].gsub(/\D/, ''),
      "return" => row[n]
    }
  end

  fund["totals"] = [
    {
      "years" => 5,
      "range" => "2009-2013",
      "return" => row[19],
      "rank" => row[20].to_i
    }, {
      "years" => 10,
      "range" => "2004-2013",
      "return" => row[21],
      "rank" => row[22].to_i
    }
  ]

  fund["trustee"] = row[1]
  fund["abn"] = row[2].to_i
  fund["type"] = row[3]
  fund["structure"] = row[4]
  fund["proportion"] = row[5]
  fund["options"] = row[6]
  fund["members"] = (row[7] * 1000).to_i
  fund["assets"] = (row[8] * 1000000).to_i

  fund
end

f = File.new("2013.json", "w")
f.write(JSON.pretty_generate(funds))
f.close
