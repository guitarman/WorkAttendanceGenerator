require "optparse"

opt_parser = OptionParser.new do |opt|

  opt.on("-p","--public PUBLIC_HOLIDAYS", Array, "Specify public holidays before generating attendance") do |public_holidays|
    puts "public_holidays"
  end

  opt.on("-l","--leave LEAVE", Array, "Specify days of your leave before generating attendance") do |leave|
    puts "leave"
  end

  opt.on("-i","--illness ILLNESS", Array, "Specify days of your illness before generating attendance") do |illness|
    puts "illness"
  end

  opt.on("-c","--compensatory COMPENSATORY", Array, "Specify days of compensatory leave before generating attendance") do |compensatory_leave|
    puts "compensatory_leave"
  end

  opt.on("-u","--unpaid UNPAID", Array, "Specify days of unpaid leave before generating attendance") do |unpaid_leave|
    puts "unpaid_leave"
  end

  opt.on("-b","--business BUSINESS", Array, "Specify days of business leave before generating attendance") do |business|
    puts "business"
  end

  opt.on("-a","--absence ABSENCE", Array, "Specify days of absence leave before generating attendance") do |absence|
    puts "absence"
  end

  opt.on("-e","--excel FILENAME", "Excel output file name") do |file|
    puts "excel"
  end

  opt.on("-h","--help","help") do
    puts opt_parser
  end

end

opt_parser.parse!