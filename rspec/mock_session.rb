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

