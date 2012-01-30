require 'openssl'  
require 'base64'

module HashHMAC_module
	def create_md5_hash(data, key)
		OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('md5'), key, data)
	end
		
	def create_base64_encode(data, key)
		 md5_hash = create_md5_hash(data, key)
		 return Base64.encode64(md5_hash).gsub(/\n/, '')
	 end 
end
