describe WebFonts, '' do
	it 'should exist' do
	end

	it 'should use a default URLRetriever' do
		webfonts = WebFonts.new
		webfonts.getAListOfProjectNames()
	end

	it 'should have a .getDomains(projectId)' do
		webfonts = WebFonts.new
		webfonts.getDomains('123')
	end

	it 'should executeAPI(params) on .getDomains(projectId)' do
		projectID = 100
		expected_url = "api.fonts.com/rest/json/Domains/?wfspstart=0&wfsplimit=999&wfspid=#{projectID}"

		webfonts = WebFonts.new

		retriever = URLRetriever.new
		webfonts.setUrlRetriever(retriever)
		webfonts.getDomains(projectID)

		URLRetriever::base_url.should eq(expected_url)
	end

	it 'should return the result of the domain parser' do
		projectID = 100
		expected_url = "api.fonts.com/rest/json/Domains/?wfspstart=0&wfsplimit=999&wfspid=#{projectID}"

		webfonts = WebFonts.new

		DomainParser::setResult('123')

		retriever = URLRetriever.new
		webfonts.setUrlRetriever(retriever)
		result = webfonts.getDomains(projectID)

		result.should eq('123')
	end

	it 'should have a .getAListOfProjectNames(format) method' do
		webfonts = WebFonts.new
		webfonts.setUrlRetriever(URLRetriever.new)
		webfonts.getAListOfProjectNames()
	end

	it 'should default to json format' do
		webfonts = WebFonts.new
		webfonts.format.should eq('json')
	end

	it 'should send the proper request when .getAListOfProjectNames is executed' do
		publicKey = '12345678'
		privateKey = 'abcdefghjijk'
		appKey = 'qwertasdf'
		format = 'json'

		urlRetriever = URLRetriever.new

		webfonts = WebFonts.new
		webfonts.setUrlRetriever(urlRetriever)
		webfonts.format = format
		webfonts.publicKey = publicKey
		webfonts.privateKey = privateKey
		webfonts.applicationKey = appKey

		webfonts.getAListOfProjectNames()

		URLRetriever::base_url.should eq('api.fonts.com/rest/json/Projects/?wfspstart=0&wfsplimit=999')
		URLRetriever::headers['authorization'].should eq('12345678%3Akwu0Aw1JW2ZlzUU%2FXUQ7qA%3D%3D')
		URLRetriever::headers['appkey'].should eq('qwertasdf')
	end

	it 'should return the response of the of the json parser' do
			retriever = URLRetriever.new
			retriever.setResponse('{"projects": [1,2,3]}')
			webfonts = WebFonts.new
			webfonts.setUrlRetriever(retriever)
			resp = webfonts.getAListOfProjectNames()

			expected_output = JSON.parse('{"projects": [1,2,3]}')
			 
			resp.should eq(expected_output)
	end
end


