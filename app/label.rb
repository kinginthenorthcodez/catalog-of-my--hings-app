require_relative './item'

class Label
  def initialize (color, title)
    @color = color
    @title = title
    @items = []
    @id = rand(1..1000)
  end
  def add_item (item)
    items << item unless items.include? (item)
    item.label = self
  end
end