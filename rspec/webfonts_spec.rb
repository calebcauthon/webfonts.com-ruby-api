require File.expand_path(File.dirname(__FILE__) + '/../lib/webfontsAccountConfig.rb')
require File.expand_path(File.dirname(__FILE__) + '/all_mocks.rb')

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
