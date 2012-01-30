class DomainParser
	@@result = false
	def self.createDomainListFromParsedJSONResponse(data)
		return @@result
	end
	def self.setResult(value)
		@@result = value
	end
end


