module DomainParser_module
  def self.createDomainListFromParsedJSONResponse(data)
		parsedJSON = JSON.parse(data)
		
		domains = parsedJSON['Domains']['Domain']
		domains
  end   
end
