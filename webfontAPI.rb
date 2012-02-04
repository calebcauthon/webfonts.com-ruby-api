require 'json'
require File.expand_path(File.dirname(__FILE__) + '/lib/listOfDomains.rb')
require File.expand_path(File.dirname(__FILE__) + '/lib/md5Hasher.rb')
require File.expand_path(File.dirname(__FILE__) + '/lib/AuthorizationHeader.rb')
require File.expand_path(File.dirname(__FILE__) + '/lib/PatronWrapper.rb')

class WebFontsAccount
	
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
	
	def getRESTResponse(headers, url)
		WebFontsAccountConfig.REST.getRESTResponse(headers, url)
	end

	def getAuthorizationHeader(url, publicKey, privateKey)
		WebFontsAccountConfig.AUTH.createAuthorizationHeader(url, publicKey, privateKey)
	end

	def executeAPICall(params)
		url_ending =	params['url_ending']
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
			@text = curler.getResponse()
			JSON.parse(@text)
		rescue
			JSON.parse('{}')
		end	
	end

	def getAListOfProjectNames()
		#url_suffix = UrlSuffixConstructor.getURL({
	#		'method': 'Projects',
	#		'start': 0,
	#		'limit': 999,
	#		'format': 'json'
	#	})

	#	full_url = createFullUrl(url_suffix)
	#	headers = createHeaders(url_suffix)
		full_url = ''
		headers = ''
		unparsedResults = getRESTResponse(headers, full_url)
		parsedResults = WebFontsAccountConfig.parser.parseProjects(unparsedResults)
		parsedResults
	end

	def getDomains(projectID)
		api_method = 'Domains'
		query_parameters = "?wfspstart=0&wfsplimit=999&wfspid=#{projectID}"
		url_ending = "/rest/#{@format}/#{api_method}/#{query_parameters}"

		params = Hash.new
		params['url_ending'] = url_ending
		parsedResult = executeAPICall(params)
#		DomainParser_module::createDomainListFromParsedJSONResponse(parsedResult)
	end
end


