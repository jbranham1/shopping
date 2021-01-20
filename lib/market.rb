require 'date'

class Market
  attr_reader :name,
              :vendors,
              :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = get_date
  end

  def get_date
    Date.today.strftime("%d/%m/%Y")
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def total_inventory
    items.each_with_object({}) do |item, hash|
      hash[item] = item_info(item)
    end
  end

  def items
    @vendors.flat_map do |vendor|
      vendor.items
    end.uniq
  end

  def item_info(item)
    {
      quantity: quantity_of_item(item),
      vendors: vendors_that_sell(item)
    }
  end

  def sorted_item_list
    items.map(&:name).sort
  end

  def overstocked_items
    items.select do |item|
      vendors_that_sell(item).count > 1 && quantity_of_item(item) > 50
    end
  end

  def sell(item, quantity)
    if quantity > quantity_of_item(item)
      false
    else
      sell_item(item, quantity)
      true
    end
  end

  def sell_item(item, quantity)
    vendors_that_sell(item).reduce(quantity) do |sell_amount, vendor|
      stock = vendor.check_stock(item)
      if sell_amount > stock
        amount_to_sell = stock
      else
        amount_to_sell = sell_amount
      end
      vendor.stock(item, -amount_to_sell)
      sell_amount -= amount_to_sell
    end
  end

  private

  def quantity_of_item(item)
    vendors_that_sell(item).sum do |vendor|
      vendor.check_stock(item)
    end
  end
end
