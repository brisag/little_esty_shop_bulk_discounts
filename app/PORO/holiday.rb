class Holiday

  def initialize(json_data)
    @parse_data = json_data #||= Holiday.new(0..-1)
  end

  def next_three_holidays
    swagger_holidays = ""
    # binding.pry
    @parse_data.each do |holiday|
      swagger_holidays += "#{holiday[:name]}, #{holiday[:date]} "
    end
    swagger_holidays[0..-1]
  end
end



# class Holiday
#   attr_reader :name,
#               :date
#   def initialize(data)
#     @name = data[:name]
#     @date = data[:date]
#   end
# end
