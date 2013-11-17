require "optparse"

options = {}
output_file = Time.now.month.to_s + ".csv"

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

  opt.on("-e","--excel FILENAME", "Excel output file name") do |file|
    output_file = file + ".xlsx"
  end

  opt.on("-h","--help","help") do
    puts opt_parser
  end

end

opt_parser.parse!

puts options
puts output_file