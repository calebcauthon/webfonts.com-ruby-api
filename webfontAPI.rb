require 'json'
require '../lib/listOfDomains.rb'
require '../lib/md5Hasher.rb'
require '../lib/AuthorizationHeader.rb'
require '../lib/PatronWrapper.rb'

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
		parsedResult = executeAPICall(params)
		DomainParser::createDomainListFromParsedJSONResponse(parsedResult)
	end
end


