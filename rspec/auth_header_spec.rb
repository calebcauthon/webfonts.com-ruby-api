class AuthorizationHeaderCreator
	include AuthorizationHeaderCreator_module
end

describe AuthorizationHeaderCreator, '' do
	it 'should exist' do
	end

	it 'should have a .createAuthorizationHeader(message, publicKey, privateKey) method' do
		a = AuthorizationHeaderCreator.new
		a.createAuthorizationHeader('', '', '')
	end

	it 'should return the right header' do
		message = '/rest/json/Projects/'
		publicKey = '12345678'
		privateKey = 'abcdefghijk'

		expected_output = '12345678%3AWr%2BuvWvYWNMDe%2Fupc4un3g%3D%3D'
		
		a = AuthorizationHeaderCreator.new
		actual_output = a.createAuthorizationHeader(message, publicKey, privateKey)
		
		actual_output.should eq(expected_output)
	end

end


