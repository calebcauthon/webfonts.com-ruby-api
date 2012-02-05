class WebFontsAccountConfig
	@@rest = false
	def self.REST=(value)
		@@rest = value
	end
	def self.REST
		@@rest
	end

	@@auth = false
	def self.AUTH=(value)
		@@auth = value
	end
	def self.AUTH
		@@auth
	end

	def self.headerConstructor=(value)
	end
	def self.urlConstructor=(value)
	end
	@@parser = false
	def self.parser=(value)
		@@parser = value
	end
	def self.parser
		@@parser
	end
end


