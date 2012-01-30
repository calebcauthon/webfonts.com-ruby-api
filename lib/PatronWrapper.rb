require 'patron'

module PatronWrapper_module
	@wrappedGift = false

	def initialize(gift=false)
		if gift == false
			gift = Patron::Session.new
		end
		@wrappedGift = gift
		@wrappedGift.timeout = 10
	end	

	def setBaseUrl(value)
		@wrappedGift.base_url = value
	end

	def addHeader(name, value)
		@wrappedGift.headers[name] = value
	end

	def getResponse
		resp = @wrappedGift.get('')
		resp.body
	end
end


class PatronWrapper
	include PatronWrapper_module
end

