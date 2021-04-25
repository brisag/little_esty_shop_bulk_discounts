class Holiday

  def initialize(json_data)
    @parse_data = json_data #||= Holiday.new(0..-1)
  end

  def next_three_holidays
    upcoming_holidays = ""
    # binding.pry
    @parse_data.each do |holiday|
      upcoming_holidays += "#{holiday[:name]}, #{holiday[:date]} "
    end
    upcoming_holidays[0..-1]
  end
end
