require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def setup
    @date = '2019-03-30'
  end

  def test_a_date_returns_a_list_of_neos
    results = NearEarthObjects.find_neos_by_date(@date)
    assert_equal '(2019 GD4)', results[:astroid_list][0][:name]
  end

  def test_it_exists_with_attributes
    neos = NearEarthObjects.new(@date)
    assert_instance_of NearEarthObjects, neos

    expected_data = [{:name=>"(2019 GD4)", :diameter=>"61 ft", :miss_distance=>"911947 miles"}, {:name=>"(2019 GN1)", :diameter=>"147 ft", :miss_distance=>"9626470 miles"}, {:name=>"(2019 GN3)", :diameter=>"537 ft", :miss_distance=>"35277204 miles"}, {:name=>"(2019 GB)", :diameter=>"81 ft", :miss_distance=>"553908 miles"}, {:name=>"(2019 FQ2)", :diameter=>"70 ft", :miss_distance=>"2788140 miles"}, {:name=>"(2011 GE3)", :diameter=>"123 ft", :miss_distance=>"35542652 miles"}, {:name=>"(2019 FT)", :diameter=>"512 ft", :miss_distance=>"5503325 miles"}, {:name=>"(2019 FS1)", :diameter=>"134 ft", :miss_distance=>"6241521 miles"}, {:name=>"141484 (2002 DB4)", :diameter=>"10233 ft", :miss_distance=>"37046029 miles"}, {:name=>"(2011 GK44)", :diameter=>"147 ft", :miss_distance=>"10701438 miles"}, {:name=>"(2012 QH8)", :diameter=>"1071 ft", :miss_distance=>"37428269 miles"}, {:name=>"(2019 UZ)", :diameter=>"51 ft", :miss_distance=>"37755577 miles"}]
    expected_diameter = 10233
    expected_number = 12

    assert_equal expected_data, neos.formatted_asteroid_data
    assert_equal expected_diameter, neos.largest_astroid_diameter
    assert_equal expected_number, neos.total_number_of_astroids
    
    assert_equal @date, neos.date
  end
end
