
def write_file(filename, output, process=false)
  input = File.open(filename, 'r')
  while line = input.gets
    output.puts line
  end
  input.close
end

def process_line(line)
  ["download", 'play', 'unmute', 'pause', 'mute'].each do |f|
    line.gsub! "{{img/#{f}.svg}}", File.open("img/#{f}.svg", 'r').read()
  end
  line.gsub! '"', '\"'
  
  line.strip
end

def write_css_string(input_filename, output)
  output.puts "mark423Styles = '<style>' + "
  input = File.open(input_filename, 'r')
  while line = input.gets
    line = process_line(line)
    output.puts "\"#{line}\" + \n"
  end
  output.puts '"</style>";'
  input.close
end

def write_html_string(input_filename, output)
  output.puts "mark423Interface = '' + "
  input = File.open(input_filename, 'r')
  while line = input.gets
    line = process_line(line)
    output.puts "\"#{line}\" + \n"
  end
  output.puts '"";'
  input.close
end

def write_tail(output)
  output.puts("console.log('Mark423 player compiled at #{Time.now.to_s}');")
end

def prepare(args)
  begin
    Dir.mkdir("build")
  rescue Errno::EEXIST
  end
end

def main(args)
  prepare(args)
  puts "== Ready to build =="
  output_file = File.open("../app/javascript/mark423-player.js", 'w')
  puts "Writing css"
  write_css_string("stylesheets/mark423-player.css", output_file)
  puts "Writing html"
  write_html_string("html/player.html", output_file)
  puts "Writing application js"
  write_file("lib/application.js", output_file, true)
  puts "Writing tail"
  write_tail(output_file)
  output_file.close
  puts "All done!"
end

main(ARGV)