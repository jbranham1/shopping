require 'minitest/pride'
require 'minitest/autorun'
require './lib/market'
require 'mocha/minitest'

class MarketTest < Minitest::Test
  def test_it_exists
    market = Market.new("South Pearl Street Farmers Market")

    assert_instance_of Market, market
  end

  def test_it_has_readable_attributes
    market = Market.new("South Pearl Street Farmers Market")

    assert_equal 'South Pearl Street Farmers Market', market.name
    assert_equal [], market.vendors
  end

  def test_add_vendor
    market = Market.new("South Pearl Street Farmers Market")
    vendor = mock
    market.add_vendor(vendor)

    assert_equal [vendor], market.vendors
  end

  def test_vendor_names
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = mock
    vendor1.stubs(:name).returns("Vendor 1")
    market.add_vendor(vendor1)

    vendor2 = mock
    vendor2.stubs(:name).returns("Vendor 2")
    market.add_vendor(vendor2)

    assert_equal ["Vendor 1", "Vendor 2"], market.vendor_names
  end
end
