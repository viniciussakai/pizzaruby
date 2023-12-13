class Cart < ApplicationRecord
  has_many :orderables
  has_many :products, through: :orderables, dependent: :destroy

  def total
    orderables.to_a.sum {
      |orderable| orderable.subtotal
    }
  end

  def count_items
    orderables.count
  end
end
