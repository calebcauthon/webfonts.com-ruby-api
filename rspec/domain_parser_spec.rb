class DomainParser
	@@result = false
	def self.createDomainListFromParsedJSONResponse(data)
		return @@result
	end
	def self.setResult(value)
		@@result = value
	end
end

class RealDomainParser
	include DomainParser_module
end

describe RealDomainParser, '' do
	it 'should parse a good json result' do
		json = '{ "Domains": {"Domain": {"DomainID":"123","DomainName":"asdf"} } }'

		result = DomainParser_module::createDomainListFromParsedJSONResponse(json)

#		result.length.should eq(1)
#		result[0]['DomainID'].should eq("123")
#		result[0]['DomainName'].should eq("asdf")
	end
end
