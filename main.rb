## FenrrirNull, bionickatana
##
## This is a program writen in ruby, that will automatically redact email
## addresses, and ip addresses. It replaces them with the generic address of
## foobar@fenrirnull.com This program is useful if you do a lot of stuff with
## AI, but don't want to tell it all about your life This works with IPv4 only
## right now
## 
## TODO: Make it so users can type custom strings to redact.
## Best for names, which vary from person to person.

# Use Ruby builtin command line parser see https://docs.ruby-lang.org/en/master/optparse/tutorial_rdoc.html
require 'optparse'

# Create the parser object
parser = OptionParser.new

# Define the options that we want:
parser.on('--redact-ip BOOL', TrueClass, 'Toggles redaction of ip addresses. Default on')

# Perform the command line parsing and spit it into the options that we can use
# later. This is the default options list that will be modified as needed by
# the parser.
options = {
  :"redact-ip" => true
}
parser.parse!(into: options)

# Now we can pull the file paths out from ARGV
if ARGV[0,1].empty?
  puts <<~ERROR
    Error: No input file specified.

    Usage:
      ruby redact.rb <input_file> <output_file> [options]

    Example:
      ruby redact.rb report.txt redacted.txt

    Run ruby redact.rb --help for more command line options.
  ERROR

  exit 1
end
INPUT_FILE = ARGV[0]
OUTPUT_FILE = ARGV[1]

# Now we can require our redaction class. Does not actually need to wait for
# the parser but all of the setup is here for logical convenience for now.
require './redact.rb'
redactor = Redact.new(options)


name = ARGV[2]
replacement_name = ARGV[3]


puts "Processing #{INPUT_FILE}"

File.open(OUTPUT_FILE, "w") do |output|

  File.foreach(INPUT_FILE) do |input_file_line|

    input_file_line = redactor.parse_line(input_file_line)
    

    #unless name.empty?
    #  input_file_line = input_file_line.gsub(name, replacement_name)
    #end
    
    puts input_file_line

    # Finally after removing all stuff from the line, write it to file
    output.write(input_file_line)
  end
end
