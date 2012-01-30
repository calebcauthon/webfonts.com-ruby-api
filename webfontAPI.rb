require 'openssl'
require 'base64'
require 'uri'
require 'json'
require 'patron'

module HashHMAC_module
	def create_md5_hash(data, key)
		OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('md5'), key, data)
	end

	def create_base64_encode(data, key)
		md5_hash = create_md5_hash(data, key)
		return Base64.encode64(md5_hash).gsub(/\n/, '')
	end
end

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

class WebFonts
	
	include AuthorizationHeaderCreator_module
	include HashHMAC_module
	
	attr_accessor :format, :publicKey, :privateKey, :applicationKey
	def initialize
		@message = ''
		@publicKey = ''
		@privateKey = ''
		@applicationKey = ''
		@retriever = false
		@format = 'json'
	end

	def setUrlRetriever(theRetriever)
		@retriever = theRetriever
	end

	def executeAPICall(params)
		url_ending =  params['url_ending']
		base_url = 'api.fonts.com'
		authorization = createAuthorizationHeader(url_ending, @publicKey, @privateKey)	
		full_url = base_url + url_ending

		if @retriever == false
			@retriever = PatronWrapper.new
		end

		curler = @retriever
		curler.setBaseUrl(full_url)
		curler.addHeader('authorization', authorization)
		curler.addHeader('appkey', @applicationKey)
		begin
			JSON.parse(curler.getResponse())
		rescue
			JSON.parse('{}')
		end	
	end

	def getAListOfProjectNames()
		api_method = 'Projects'
		query_parameters = '?wfspstart=0&wfsplimit=999'
		url_ending = "/rest/#{@format}/#{api_method}/#{query_parameters}"

		params = Hash.new
	  params['url_ending'] = url_ending	
		executeAPICall(params)
	end

	def getDomains(projectID)
		api_method = 'Domains'
		query_parameters = "?wfspstart=0&wfsplimit=999&wfspid=#{projectID}"
		url_ending = "/rest/#{@format}/#{api_method}/#{query_parameters}"

		params = Hash.new
		params['url_ending'] = url_ending
		executeAPICall(params)
	end
end

module PatronWrapper_module
	@wrappedGift = false

	def initialize(gift=false)
		if gift == false
			gift = Patron::Session.new
		end
		@wrappedGift = gift
		@wrappedGift.timeout = 10
	end	

	def setBaseUrl(value)
		@wrappedGift.base_url = value
	end

	def addHeader(name, value)
		@wrappedGift.headers[name] = value
	end

	def getResponse
		resp = @wrappedGift.get('')
		resp.body
	end
end

class PatronWrapper
	include PatronWrapper_module
end

