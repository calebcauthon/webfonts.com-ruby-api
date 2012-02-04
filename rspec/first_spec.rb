require '../webfontAPI.rb'
#require 'hash_HMAC_spec.rb'
#require 'auth_header_spec.rb'
#require 'mock_url_retriever.rb'
#require 'mock_domain_parser.rb'
require 'webfonts_spec.rb'
#require 'mock_session.rb'
#require 'patron_wrapper_spec.rb'
#require 'domain_parser_spec.rb'
#
=======

class HashHMAC
  include HashHMAC_module
end

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

class URLRetriever
  @@base_url = false
  @@headers = Hash.new

  @@response = false

  def self.headers
    @@headers
  end
  def self.addHeader(name, value)
    @@headers[name] = value
  end

  def self.base_url=(value)
    @@base_url = value
  end
  def	self.base_url
    @@base_url
  end

  def setBaseUrl(value)
    URLRetriever::base_url = value
  end
  def addHeader(name, value)
    URLRetriever::addHeader(name, value)
  end

  def setResponse(value)
    @@response = value
  end

  def getResponse
    @@response
  end
end

describe WebFonts, '' do
  it 'should exist' do
  end

  it 'should use a default URLRetriever' do
    webfonts = WebFonts.new
    webfonts.getAListOfProjectNames()
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

describe HashHMAC, '' do
  it 'should exist' do
  end

  it 'should return a base64_encode value' do
    data = '12345678|/rest/json/Projects/'
    key = '12345678'
    expected_output = '/8hWiYH90zHIPtxJbluX/w=='

    s = HashHMAC.new
    actual_output = s.create_base64_encode(data, key)

    actual_output.should eq(expected_output)
  end
end

class MockSession
  attr_accessor :base_url, :headers, :getCalled, :get_parameter, :timeout
  def initialize
    @headers = Hash.new
    @getCalled = false
  end

  def get(value)
    @getCalled = true
    @get_parameter = value
    resp = FakePatronResponse.new
  end
end

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

class ProjectResponse
  include ProjectList_module
end

$json = '{ "Projects": {"Message": "Success", "PageLimit": "10", "PageStart": "0", "Project": [ {"ProjectKey": "1", "ProjectName": "mockProject" }], "TotalRecords": "1", "UserId": "112345", "UserRole": "Pro" }}'

describe ProjectResponse, '' do			
  it 'should exist' do
  end

  it 'should return a has with a "Projects" element' do
    pr = ProjectResponse.new
    parsedJSON = pr.parse($json)
    parsedJSON['Projects'].should_not be_nil
  end

  it 'should return a projects element which contains a hash which has a Message element' do
    pr = ProjectResponse.new
    parsedJSON = pr.parse($json)
    parsedJSON['Projects']['Message'].should_not be_nil
  end
end
