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

