# class ApiService
#   def self.get_data(endpoint)
#     response = Faraday.get(endpoint)
#     parse_data = response.body
#     JSON.parse(parse_data, symbolize_names: true)
#   end
# end
