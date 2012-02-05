class MockParser
	@@response = false
	def self.set_parseProjectsList_response(response)
		@@response = response
	end
	@@input = false
	def self.input
		@@input
	end
	def parseProjects(unparsedText)
		@@input = unparsedText
		@@response
	end
end


