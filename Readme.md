# Usage

`ruby main.rb <input_file> <output_file> [options]`

# Run tests

`rspec`

# TODO

- [ ] Flesh out testing
  - [ ] Custom string testing
  - [ ] Finish IP matching testing
    - [x] Validate IPv4 addresses before changing them
    - [ ] Fix IPv6 matches. This is questionably working. Embedded IPv4 does not substitue properly.
    - [ ] Fix embedded IPv4 addresses in IPv6
