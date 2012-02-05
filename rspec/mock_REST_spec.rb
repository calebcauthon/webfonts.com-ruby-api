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

