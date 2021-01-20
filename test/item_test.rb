require 'minitest/pride'
require 'minitest/autorun'
require './lib/item'

class ItemTest < Minitest::Test
  def test_it_exists
    item = Item.new({name: 'Peach', price: "$0.75"})

    assert_instance_of Item, item
  end
end
