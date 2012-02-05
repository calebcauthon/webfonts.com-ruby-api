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

