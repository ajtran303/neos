require 'faraday'
require 'figaro'
require 'pry'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  attr_reader :date,
              :formatted_asteroid_data,
              :largest_astroid_diameter,
              :total_number_of_astroids

  def self.find_neos_by_date(date)
    neos = new(date)

    {
      astroid_list: neos.formatted_asteroid_data,
      biggest_astroid: neos.largest_astroid_diameter,
      total_number_of_astroids: neos.total_number_of_astroids
    }
  end

  def initialize(date)
    @date = date
    @formatted_asteroid_data = get_formatted_asteroid_data
    @largest_astroid_diameter = get_largest_astroid_diameter
    @total_number_of_astroids = get_total_number_of_astroids
  end

  private

  def conn
    Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )
  end

  def asteroids_list_data
    conn.get('/neo/rest/v1/feed')
  end

  def parsed_asteroids_data
    @parsed_asteroids_data ||= JSON.parse(asteroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
  end

  def get_formatted_asteroid_data
    parsed_asteroids_data.map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end

  def get_largest_astroid_diameter
    parsed_asteroids_data.map do |astroid|
      astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a<=> b}
  end

  def get_total_number_of_astroids
    parsed_asteroids_data.count
  end
end
