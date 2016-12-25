require_relative 'weather_forecast'
require 'figaro'

Figaro.application = Figaro::Application.new(
  path: File.expand_path("./config/application.yml")
)

Figaro.load

