## FenrrirNull, bionickatana
##
## Redaction class. Handles the actual redaction of the files.


DEFAULT_IP_ADDRESS = "192.168.10.10"
DEFAULT_EMAIL_ADDRESS = "foobar@fenrirnull.com"


class Redact
  # Initializes the Redact class for usage.
  #
  # @param [Hash] options to perform on the data.
  def initialize(options)
    @options = options
  end

  # Parses a single line.
  #
  # @param [String] the line to be parsed.
  # @retval [String] the redacted line.
  def parse_line(line)
    # Check if we should redact ip addresses:
    if @options[:"redact-ip"] && @options[:"redact-ip"] == true
      line = line.gsub(/\b(?:\d{1,3}\.){3}\d{1,3}\b/, DEFAULT_IP_ADDRESS)
    end

    if @options[:'redact-email'] && @options[:'redact-email'] == true
      line = line.gsub(/\b[A-Za-z0-9._%+-]+@[A-Za-z]+\.[A-Za-z]{2,}\b/, DEFAULT_EMAIL_ADDRESS)
    end

    # Finally after removing all of the stuff from the line, send it back
    return line
  end
end
