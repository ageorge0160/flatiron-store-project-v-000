class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items

  belongs_to :user

  def total
    total = 0
    line_items.each {|line_item| total = total + line_item.item.price * line_item.quantity}
    total
  end

  def place_order
    self.status = "submitted"
    line_items.each do |line_item|
      line_item.item.inventory = line_item.item.inventory - line_item.quantity
      line_item.item.save
    end
    self.save
  end

  def add_item(new_item_id)
		new_item = Item.find(new_item_id)
		if self.items.include?(new_item)
			line_item = self.line_items.find_by(item_id: new_item_id)
			line_item.quantity += 1
			line_item.save
		else
			line_item = self.line_items.build(item_id: new_item_id, quantity: 1)
		end
		line_item
	end

end
