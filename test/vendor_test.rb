require 'minitest/pride'
require 'minitest/autorun'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_instance_of Vendor, vendor
  end

  def test_it_has_readable_attributes
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal 'Rocky Mountain Fresh', vendor.name
    assert_equal Hash.new, vendor.inventory
  end
end
