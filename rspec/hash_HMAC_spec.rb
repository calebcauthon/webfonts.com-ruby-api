class HashHMAC
	include HashHMAC_module
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


