require 'minitest/pride'
require 'minitest/autorun'
require './lib/market'
require './lib/item'
require './lib/vendor'
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

  def test_vendor_that_sell
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 65)
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal [vendor1, vendor3], market.vendors_that_sell(item1)
  end

  def test_total_inventory
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 65)
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    inventory_hash = {
      item1 => "",
      item2 => "",
      item4 => "",
      item3 => ""
    }

    assert_equal inventory_hash, market.total_inventory
  end

  def test_items
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 65)
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal [item1, item2, item4, item3], market.items
  end

  def test_item_info
    market = Market.new("South Pearl Street Farmers Market")
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    vendor1.stock(item1, 35)
    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 65)
    market.add_vendor(vendor1)
    market.add_vendor(vendor3)

    info_hash = {
      quantity: 100,
      vendors: [vendor1, vendor3]
    }
    assert_equal info_hash, market.item_info(item1)
  end
end
