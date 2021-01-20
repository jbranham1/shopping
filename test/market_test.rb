require 'minitest/pride'
require 'minitest/autorun'
require './lib/market'
require 'mocha/minitest'

class MarketTest < Minitest::Test
  def test_it_exists
    market = Market.new("South Pearl Street Farmers Market")

    assert_instance_of Market, market
  end
end
