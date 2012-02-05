class MockAUTH
	@@url = false
	def self.url
		@@url
	end

	@@privateKey = false
	def self.privateKey
		@@privateKey
	end

	@@publicKey = false
	def self.publicKey
		@@publicKey
	end

	def createAuthorizationHeader(url, publicKey, privateKey)
		@@url = url
		@@privateKey = privateKey
		@@publicKey = publicKey
	end
end


