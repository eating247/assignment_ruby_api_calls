#run from CLI with $ API_KEY=your_key ruby weather_forecast.rb


class WeatherForecast

  END_POINT = "http://api.openweathermap.org/data/2.5/forecast/daily?"

  API_KEY = ENV["WEATHER_API"]

  def initialize(city_id=5128638, days=1)
    @days = days
    @forecast = build_forecast(build_url(city_id, days))
  end

  def build_forecast(url)
    sleep(0.5)
    response = HTTParty.get(url)
    response['list']
  end

  def hi_temps
    puts "Maximum temperatures over the next #{@days} days:"
    @forecast.map {|day| puts day["temp"]["max"] }
  end

  def lo_temps
    puts "Minimum temperatures over the next #{@days} days:"
    @forecast.map {|day| puts day["temp"]["min"] }
  end

  def pressures
    puts "Pressures over the next #{@days} days:"
    @forecast.map {|day| puts day["pressure"] }
  end

  def forecasts
    puts "Forecasts over the next #{@days} days:"
    @forecast.map {|day| puts day["weather"].first["description"] }
  end

  def humidities
    puts "Humidities over the next #{@days} days:"
    @forecast.map {|day| puts day["humidity"] }
  end

  def today
    puts "Today's Weather:"
    puts 
    day_specific_forecast(0)
  end

  def tomorrow
    puts "Tomorrow's Weather:"
    puts
    day_specific_forecast(1)
  end

  private

    def build_url(city_id, days)
      END_POINT + "id=#{city_id}&cnt=#{days}&APPID=#{API_KEY}"
    end

    def day_specific_forecast(day)
      forecast = @forecast[day]
      puts "FORECAST"
      puts forecast["weather"].first["description"]
      puts
      puts "TEMPERATURES"
      forecast["temp"].each { |k,v| puts "#{k}: #{v}" }
    end

end