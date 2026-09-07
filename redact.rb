## FenrrirNull, bionickatana
##
## Redaction class. Handles the actual redaction of the files.


class Redact
  DEFAULT_IP_ADDRESS = "192.168.10.10"
  DEFAULT_EMAIL_ADDRESS = "foobar@fenrirnull.com"


  # Initializes the Redact class for usage.
  #
  # @param [Hash] options to perform on the data.
  def initialize(options)
    @options = options
  end

  # Parses the given string and performs specified redactions
  #
  # @param [String] the data to be parsed.
  # @retval [String] the redacted data.
  def parse_data(data)
    # Check if we should redact ip addresses:
    if @options[:"redact-ip"] && @options[:"redact-ip"] == true
      data.gsub!(/\b(?:\d{1,3}\.){3}\d{1,3}\b/, DEFAULT_IP_ADDRESS)
    end

    if @options[:'redact-email'] && @options[:'redact-email'] == true
      data.gsub!(/(?:"[^"]+"|[a-zA-Z0-9_.+\-]+)@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}|\d{1,3}(?:\.\d{1,3}){3}|\[\d{1,3}(?:\.\d{1,3}){3}\])/, DEFAULT_EMAIL_ADDRESS)
    end


    #Iterate through the redact-string list to make sure that all of the strings were redacted
    
    idx = 0
    while idx < @options[:'redact-string'].length

      if @options[:'redact-string']
        name = @options[:'redact-string'][idx]
        replacement_name = @options[:'redact-string'][idx + 1]
        data.gsub!(name, replacement_name)
      end

      idx += 2

    end
    # Finally after removing all of the stuff from the data, send it back
    return data
  end
end
