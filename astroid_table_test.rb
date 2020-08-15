require "minitest/autorun"
require "minitest/pride"
require_relative "astroid_table"
require_relative 'near_earth_objects'


class AstroidTableTest < Minitest::Test
  def setup
    @date = '2019-03-30'
    @astroids = NearEarthObjects.find_neos_by_date(@date)[:astroid_list]
    @astroid_table = AstroidTable.new(@astroids)
  end

  def test_it_can_create_table
    assert_nil AstroidTable.create_table(@astroids)
  end

  def test_it_exists
    assert_instance_of AstroidTable, @astroid_table
  end

  def test_it_has_attributes
    expected_header = "| Name              | Diameter | Missed The Earth By: |"
    expected_divider = "+-------------------+----------+----------------------+"
    expected_rows = 
      [
        {:name=>"(2019 GD4)", :diameter=>"61 ft", :miss_distance=>"911947 miles"},
        {:name=>"(2019 GN1)", :diameter=>"147 ft", :miss_distance=>"9626470 miles"},
        {:name=>"(2019 GN3)", :diameter=>"537 ft", :miss_distance=>"35277204 miles"},
        {:name=>"(2019 GB)", :diameter=>"81 ft", :miss_distance=>"553908 miles"},
        {:name=>"(2019 FQ2)", :diameter=>"70 ft", :miss_distance=>"2788140 miles"},
        {:name=>"(2011 GE3)", :diameter=>"123 ft", :miss_distance=>"35542652 miles"},
        {:name=>"(2019 FT)", :diameter=>"512 ft", :miss_distance=>"5503325 miles"},
        {:name=>"(2019 FS1)", :diameter=>"134 ft", :miss_distance=>"6241521 miles"},
        {:name=>"141484 (2002 DB4)", :diameter=>"10233 ft", :miss_distance=>"37046029 miles"},
        {:name=>"(2011 GK44)", :diameter=>"147 ft", :miss_distance=>"10701438 miles"},
        {:name=>"(2012 QH8)", :diameter=>"1071 ft", :miss_distance=>"37428269 miles"},
        {:name=>"(2019 UZ)", :diameter=>"51 ft", :miss_distance=>"37755577 miles"}
      ]

    assert_equal expected_header, @astroid_table.header
    assert_equal expected_divider, @astroid_table.divider
    assert_equal expected_rows, @astroid_table.create_rows
  end
end
