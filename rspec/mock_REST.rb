class MockREST
	@@headers = false
	@@url = false
	def self.headers
		@@headers
	end
	def self.url
		@@url
	end

	@@response = false
	def self.set_getRESTResponse_response(response)
		@@response = response
	end
	def getRESTResponse(headers, url)
		@@headers = headers
		@@url = url
		@@response
	end	
end

