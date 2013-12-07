# encoding: UTF-8
require "optparse"
require "date"
require "csv"

options = {}
output_file = "output.csv"
year = Time.now.year
month = Time.now.month

#inspired by rails implementation
COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def days_in_month(month)
  return 29 if month == 2 && Date.gregorian_leap?(year)
  COMMON_YEAR_DAYS_IN_MONTH[month]
end

def add_to_options(options, params, value)
  params.each { |param| options[param.to_s] = value }
end

opt_parser = OptionParser.new do |opt|

  opt.on("-p","--public PUBLIC_HOLIDAYS", Array, "Specify public holidays before generating attendance") do |public_holidays|
    add_to_options(options, public_holidays, "SV")
  end

  opt.on("-l","--leave LEAVE", Array, "Specify days of your leave before generating attendance") do |leave|
    add_to_options(options, leave, "D")
  end

  opt.on("-i","--illness ILLNESS", Array, "Specify days of your illness before generating attendance") do |illness|
    add_to_options(options, illness, "CH")
  end

  opt.on("-c","--compensatory COMPENSATORY", Array, "Specify days of compensatory leave before generating attendance") do |compensatory_leave|
    add_to_options(options, compensatory_leave, "NV")
  end

  opt.on("-u","--unpaid UNPAID", Array, "Specify days of unpaid leave before generating attendance") do |unpaid_leave|
    add_to_options(options, unpaid_leave, "V")
  end

  opt.on("-b","--business BUSINESS", Array, "Specify days of business leave before generating attendance") do |business|
    add_to_options(options, business, "SC")
  end

  opt.on("-a","--absence ABSENCE", Array, "Specify days of absence leave before generating attendance") do |absence|
    add_to_options(options, absence, "A")
  end

  opt.on("-m","--month MONTH", Integer, "Month which attendance should be generated for") do |month_num|
    puts month_num.class
    month = month_num if month_num.between?(1,12)
    puts month
  end

  opt.on("-e","--excel FILENAME", "Excel output file name") do |file|
    output_file = file + ".xlsx"
  end

  opt.on("-h","--help","Help") do
    puts opt_parser
  end

end

opt_parser.parse!

days = days_in_month(month)

CSV.open(output_file, "w:utf-8") do |csv|
  for i in 1..days do
    date = DateTime.new(year, month, i)
    case date.wday
      when 6,0
        attendance = "Víkend"
      else
        attendance = options.key?(i.to_s) ? options[i.to_s] : "P"
    end
    csv << [date.strftime("%d/%m/%Y"), attendance]
  end
end
