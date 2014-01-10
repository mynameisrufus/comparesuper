require 'roo'
require 'json'
require 'pry'

xls = Roo::Excel.new("2013.xls")

heading = xls.sheet(4).row(3)
dates = xls.sheet(4).row(4)
rows = (5..204).map { |row|  xls.sheet(4).row(row) }

funds = rows.map do |row|

  fund = {}

  fund["name"] = row[0]
  fund["trustee"] = row[1]
  fund["ABN"] = row[2].to_i
  fund["type"] = row[3]
  fund["typeCode"] = row[3].downcase.gsub(/\s/, '')
  fund["benefitStructure"] = row[4]
  fund["defaultStrategy"] = row[5]
  fund["investmentOptions"] = row[6].to_i
  fund["members"] = (row[7] * 1000).to_i
  fund["totalAssets"] = (row[8] * 1000000).to_i
  fund["NAVPM"] = fund["totalAssets"] / fund["members"]

  fund["yearlyReturns"] = (9..18).inject({}) do |h, n|
    h[dates[n].gsub(/\D/, '')] = {
      "month" => "June",
      "ROR" => row[n]
    }
    h
  end

  fund["comparisons"] = {
    "2012-2013" => {
      "range" => 1,
      "ROR" => row[18],
      "rank" => nil,
      "count" => rows.size
    },
    "2009-2013" => {
      "range" => 5,
      "ROR" => row[19],
      "rank" => row[19].nil? ? nil : row[20].to_i,
      "count" => rows.size
    },
    "2004-2013" => {
      "range" => 10,
      "ROR" => row[21],
      "rank" => row[21].nil? ? nil : row[22].to_i,
      "count" => rows.size
    }
  }

  fund
end

funds.sort! { |a, b| a["comparisons"]["2012-2013"]["ROR"].to_i <=> b["comparisons"]["2012-2013"]["ROR"].to_i }
funds.each_with_index { |f, i|
  f["comparisons"]["2012-2013"]["rank"] = f["comparisons"]["2012-2013"]["ROR"].nil? ? nil : i + 1
}
funds.sort! { |a, b| a["name"] <=> b["name"] }

f = File.new("app/data/2013.json", "w")
f.write(JSON.pretty_generate(funds))
f.close
