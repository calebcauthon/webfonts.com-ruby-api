class FakePatronResponse
	def body
		'fake response'
	end
end

class PatronWrapper
	include PatronWrapper_module
end
describe PatronWrapper, '' do
	it 'should set timeout = 10' do
		mockedSession = MockSession.new
		wrap = PatronWrapper.new(mockedSession)

		mockedSession.timeout.should eq(10)
	end
	it 'should set the baseURL of whatever its given' do
		mockedSession = MockSession.new
		wrap = PatronWrapper.new(mockedSession)
		wrap.setBaseUrl('asdf')

		mockedSession.base_url.should eq('asdf')
	end

	it 'should add hashes when addHeader(name, value) is used' do
		mockedSession = MockSession.new
		wrap = PatronWrapper.new(mockedSession)
		wrap.addHeader('name', 'simon')

		mockedSession.headers['name'].should eq('simon')
	end

	it 'should call .get("") and return the .body attribute' do
		mockedSession = MockSession.new
		wrap = PatronWrapper.new(mockedSession)
		resp = wrap.getResponse()

		mockedSession.getCalled.should eq(true)
		mockedSession.get_parameter.should eq('')
		resp.should eq('fake response')

	end

	it 'should create a new patron object if one isnt passed in' do

		mockedSession = MockSession.new
		wrap = PatronWrapper.new
		resp = wrap.setBaseUrl('test')
	end
end
