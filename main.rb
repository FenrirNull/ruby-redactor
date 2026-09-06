## FenrrirNull
## This is a program writen in ruby, that will automatically
## redact email addresses, and ip addresses. It
## replaces them with the generic address of
## foobar@fenrirnull.com
## This program is useful if you do a lot of stuff with AI,
## but don't want to tell it all about your life
## This works with IPv4 only right now
## 
## TODO: Make it so users can type custom strings to redact.
## Best for names, which vary from person to person.


input_file = ARGV[0]
output_file = ARGV[1]
name = ARGV[2]
replacement_name = ARGV[3]

ip_address = "192.168.10.10"
email_address = "foobar@fenrirnull.com"

if ARGV[0,1].empty?
  puts <<~ERROR
    Error: No input file specified.

    Usage:
      ruby main.rb <input_file> <output_file> [name_to_replace] [replacment name]

    Example:
      ruby main.rb report.txt redacted.txt Fenrir Bob
  ERROR

  exit 1
end

puts "Processing #{input_file}"

File.open(output_file, "w") do |output|

  File.foreach(input_file) do |line|
    
    line = line.gsub(/\b(?:\d{1,3}\.){3}\d{1,3}\b/, ip_address)

    line = line.gsub(/\b[A-Za-z0-9._%+-]+@[A-Za-z]+\.[A-Za-z]{2,}\b/, email_address)

    unless name.empty?
      line = line.gsub(name, replacement_name)
    end
    
    puts line

    output.write(line)
    
  end
end
