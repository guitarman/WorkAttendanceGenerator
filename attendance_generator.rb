# encoding: UTF-8
require "optparse"
require "date"
require "csv"
require "holidays"

@options = {}
output_file = "output.csv"
year = Time.now.year
month = Time.now.month

#inspired by rails implementation
COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def days_in_month(year, month)
  return 29 if month == 2 && Date.gregorian_leap?(year)
  COMMON_YEAR_DAYS_IN_MONTH[month]
end

def add_to_options(params, value)
  params.each { |param| @options[param.to_i.to_s] = value }
end

def holidays_for_month(year, month)
  holidays = Holidays.between(Date.new(year, month, 1), Date.new(year, month, -1), :sk)
  h_day_numbers = holidays.map{ |holiday| holiday[:date].strftime('%d')}
  add_to_options(h_day_numbers, 'SV')
end

opt_parser = OptionParser.new do |opt|

  opt.on("-p","--public PUBLIC_HOLIDAYS", Array, "Specify public holidays") do |public_holidays|
    add_to_options(public_holidays, "SV")
  end

  opt.on("-l","--leave LEAVE", Array, "Specify days of leave") do |leave|
    add_to_options(leave, "D")
  end

  opt.on("-i","--illness ILLNESS", Array, "Specify days of illness") do |illness|
    add_to_options(illness, "CH")
  end

  opt.on("-c","--compensatory COMPENSATORY", Array, "Specify days of compensatory leave") do |compensatory_leave|
    add_to_options(compensatory_leave, "NV")
  end

  opt.on("-u","--unpaid UNPAID", Array, "Specify days of unpaid leave") do |unpaid_leave|
    add_to_options(unpaid_leave, "V")
  end

  opt.on("-b","--business BUSINESS", Array, "Specify days of business leave") do |business|
    add_to_options(business, "SC")
  end

  opt.on("-a","--absence ABSENCE", Array, "Specify days of absence") do |absence|
    add_to_options(absence, "A")
  end

  opt.on("-m","--month MONTH", Integer, "Month which attendance should be generated for") do |month_num|
    month = month_num if month_num.between?(1,12)
  end

  opt.on("-o","--output FILE", "Output file name") do |file_name|
    file_name += '.csv' unless file_name =~ /\.csv/
    output_file = file_name
  end

  opt.on("-e","--excel FILENAME", "Generating output to specified excel (without extension) file ") do |file|
    output_file = file + ".xlsx"
  end

  opt.on("-h","--help","Help") do
    puts opt_parser
  end

end

opt_parser.parse!

days = days_in_month(year, month)

CSV.open(output_file, "w:utf-8") do |csv|
  holidays_for_month(year, month)
  for i in 1..days do
    date = Date.new(year, month, i)
    case date.wday
      when 6,0
        attendance = "Víkend"
      else
        attendance = @options.key?(i.to_s) ? @options[i.to_s] : "P"
    end
    csv << [date.strftime("%d/%m/%Y"), attendance]
  end
end
