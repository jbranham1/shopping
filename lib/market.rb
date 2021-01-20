class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
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
      hash[item] = ""
    end
  end

  def items
    @vendors.flat_map do |vendor|
      vendor.inventory.keys
    end.uniq
  end
end
