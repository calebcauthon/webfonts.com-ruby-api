require 'uri'

module AuthorizationHeaderCreator_module
	class HMACKER
		include HashHMAC_module
	end

  def createAuthorizationHeader(message, publicKey, privateKey)
		data = publicKey + '|' + message

		hasher = HMACKER.new
		hash = hasher.create_base64_encode(data, privateKey)
	  header = publicKey + ':' + hash 
	  urlEncodedHeader = URI.encode(header, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
		return urlEncodedHeader
	end
end
