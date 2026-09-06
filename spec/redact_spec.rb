## bionickatana
##
## Test file for the Redact class. Validates functionality

require './redact.rb'

require './spec/test_data.rb'

RSpec.describe Redact do
  describe '#initialize' do
    it 'initializes successfully' do
      expect(Redact.new({})).to be_a(Redact)
    end
  end

  describe '#parse_data' do
    describe 'ip addresses' do
      it 'are redacted when requested' do
        redactor = Redact.new({:'redact-ip' => true})
        TestData::IPV4.each do |ipv4_address|
          expect(redactor.parse_data(ipv4_address)).to eq(Redact::DEFAULT_IP_ADDRESS)
        end

        TestData::IPV6.each do |ipv6_address|
          expect(redactor.parse_data(ipv6_address)).to eq(Redact::DEFAULT_IP_ADDRESS)
        end
      end
      
      it 'are ignored when requested' do
        redactor = Redact.new({:'redact-ip' => false})
        TestData::IPV4.each do |ipv4_address|
          expect(redactor.parse_data(ipv4_address)).to eq(ipv4_address)
        end

        TestData::IPV6.each do |ipv6_address|
          expect(redactor.parse_data(ipv6_address)).to eq(ipv6_address)
        end        
      end
      
      it 'are ignored when malformed' do
        redactor = Redact.new({:'redact-ip' => true})
        TestData::IPV4NOT.each do |ipv4_address|
          expect(redactor.parse_data(ipv4_address)).to eq(ipv4_address)
        end

        TestData::IPV6NOT.each do |ipv6_address|
          expect(redactor.parse_data(ipv6_address)).to eq(ipv6_address)
        end        
      end
    end
    
    describe 'emails' do
      it 'are redacted when requested' do
        redactor = Redact.new({:'redact-email' => true})

        # test each email individually
        TestData::EMAILS.each do |email|
          expect(redactor.parse_data(email)).to eq(Redact::DEFAULT_EMAIL_ADDRESS)
        end

        # Test multiple emails in a chunk
        expect(redactor.parse_data(TestData::EMAILS.join(' '))).to eq('foobar@fenrirnull.com' + (' foobar@fenrirnull.com' * (TestData::EMAILS.length - 1)))
      end
      
      it 'are ignored when requested' do
        redactor = Redact.new({:'redact-email' => false})
        TestData::EMAILS.each do |email|
          expect(redactor.parse_data(email)).to eq(email)
        end      

        # Test multiple emails in a chunk
        expect(redactor.parse_data(TestData::EMAILS.join(' '))).to eq(TestData::EMAILS.join(' '))
      end
    end
  end
end
