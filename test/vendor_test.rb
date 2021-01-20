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

  def test_check_stock_for_item_not_in_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    item = mock
    assert_equal 0, vendor.check_stock(item)
  end

  def test_potential_revenue
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = mock
    item2 = mock

    item1.stubs(:price).returns(0.75)
    item2.stubs(:price).returns(0.50)

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    assert_equal 29.75, vendor1.potential_revenue
  end

  def test_items
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = mock
    item2 = mock
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    assert_equal [item1, item2], vendor1.items
  end
end
