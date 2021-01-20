require 'minitest/pride'
require 'minitest/autorun'
require './lib/vendor'
require 'mocha/minitest'

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

  def test_check_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    item = mock
    assert_equal 0, vendor.check_stock(item)

    vendor.stock(item, 30)

    assert_equal 30, vendor.check_stock(item)
  end

  def test_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    item = mock

    vendor.stock(item, 30)
    inventory_hash = {item => 30}
    assert_equal inventory_hash, vendor.inventory
  end
end
