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

class WebFontsAccountConfig
	@@rest = false
	def self.REST=(value)
		@@rest = value
	end
	def self.REST
		@@rest
	end

	@@auth = false
	def self.AUTH=(value)
		@@auth = value
	end
	def self.AUTH
		@@auth
	end

	def self.headerConstructor=(value)
	end
	def self.urlConstructor=(value)
	end
	@@parser = false
	def self.parser=(value)
		@@parser = value
	end
	def self.parser
		@@parser
	end
end

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

describe MockAUTH, '' do
	it 'should exist' do
	end
	it 'should set .url, .publicKey, .privateKey to whatever is passed into .createAuthorizationHeader' do
		publicKey = 'abc'
		privateKey = 'xyz'
		url = 'www.website.com'

		auth = MockAUTH.new
		auth.createAuthorizationHeader(url, publicKey, privateKey)

		MockAUTH.url.should eq(url)
		MockAUTH.privateKey.should eq(privateKey)
		MockAUTH.publicKey.should eq(publicKey)
	end
end

describe WebFontsAccountConfig, '' do
	it 'should exist' do
	end
	it 'should have a .REST and .REST=' do
		WebFontsAccountConfig.REST = 'xyz'
		WebFontsAccountConfig.REST.should eq('xyz')
	end
	it 'should have a .AUTH and a .AUTH=' do
		WebFontsAccountConfig.AUTH = 'abc'
		WebFontsAccountConfig.AUTH.should eq('abc')
	end
	it 'should have a .parser and a .parser=' do
		WebFontsAccountConfig.parser = '123'
		WebFontsAccountConfig.parser.should eq('123')
	end
end

describe MockREST, '' do
	it 'should exist' do 
	end
	it 'should set headers to whatever the value1 of MockREST.new.getRESTRespone(value1, value2) is' do
		MockREST.headers.should_not eq('headers')
		MockREST.new.getRESTResponse('headers', true)

		MockREST.headers.should eq('headers')
	end

	it 'should set the url to whatever the value2 of MockREST.new.getRESTResponse(value1, value2) is' do
		MockREST.url.should_not eq('www.url.com')
		MockREST.new.getRESTResponse('headers', 'www.url.com')

		MockREST.url.should eq('www.url.com')
	end

	context '.getRESTResponse' do 
		it 'should return whatever was set with .set_getRESTResponse_response' do
			MockREST.set_getRESTResponse_response('SOLID')
			rest = MockREST.new
			response = rest.getRESTResponse(true, true)
			response.should eq('SOLID')

		end
	end

end

class MockFullUrlConstructor
	def self.set_createFullUrl_response(response)
	end
end

class MockHeadersConstructor
	def self.set_createHeaders_response(response)
	end
end

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

describe WebFontsAccount, '' do
	it 'should exist' do
	end
	context '.getAListOfProjectNames' do
		it 'should return the parsed results of getRESTResponse(headers, url)' do
			headers = Hash.new
			headers['name'] = 'Pete'
			headers['day'] = 'Tuesday'
			MockFullUrlConstructor.set_createFullUrl_response('www.example.com')
			MockHeadersConstructor.set_createHeaders_response(headers)

			MockParser.set_parseProjectsList_response('alarm')
			
			MockREST.set_getRESTResponse_response('text123')

			WebFontsAccountConfig.headerConstructor = MockHeadersConstructor.new
			WebFontsAccountConfig.urlConstructor = MockFullUrlConstructor.new
			WebFontsAccountConfig.parser = MockParser.new
			WebFontsAccountConfig.REST = MockREST.new

			account = WebFontsAccount.new
			accountResponse = account.getAListOfProjectNames()

			accountResponse.should eq('alarm')
			MockParser.input.should eq('text123')
		end
	end
	context 'REST' do
		it 'should have a method for calling REST methods' do
			headers = Array.new
			url = 'http://www.example.com'

			WebFontsAccountConfig.REST = MockREST.new
			account = WebFontsAccount.new
			account.getRESTResponse(headers, url)
		end

		it 'should use whatevers in Config.REST for .getRestResponse' do
			WebFontsAccountConfig.REST = MockREST.new
			
			account = WebFontsAccount.new
			account.getRESTResponse('this header', 'url')

			MockREST.headers.should eq('this header')
			MockREST.url.should eq('url')
		end

		it 'should use whatevers in Config.AUTH for .getAuthorizationHeader' do
			WebFontsAccountConfig.AUTH = MockAUTH.new

			account = WebFontsAccount.new
			account.getAuthorizationHeader('url', 'pubkey', 'privkey')

			MockAUTH.url.should eq('url')
			MockAUTH.publicKey.should eq('pubkey')
			MockAUTH.privateKey.should eq('privkey')
		end
	end

	context 'auth' do
		it 'should have a parameter that expect 3 parameters - url, public key, private key' do
			account = WebFontsAccount.new
			account.getAuthorizationHeader('url', 'pubkey', 'privkey') 
		end

		it 'should pass those parameters on to whatever is in WebFontsAccountConfig.AUTH.getAuthorizationHeader(a,b,c)' do
		end
	end
end
