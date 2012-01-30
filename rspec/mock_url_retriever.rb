class URLRetriever
	@@base_url = false
	@@headers = Hash.new

	@@response = false

	def self.headers
		@@headers
	end
	def self.addHeader(name, value)
		@@headers[name] = value
	end

	def self.base_url=(value)
		@@base_url = value
	end
	def	self.base_url
		@@base_url
	end

	def setBaseUrl(value)
		URLRetriever::base_url = value
	end
	def addHeader(name, value)
		URLRetriever::addHeader(name, value)
	end

	def setResponse(value)
		@@response = value
	end

	def getResponse
		@@response
	end
end


