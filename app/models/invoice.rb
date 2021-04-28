class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def find_discount
    items.joins(merchant: :discounts)
    .select("invoice_items.item_id, max(invoice_items.quantity * invoice_items.unit_price * discounts.percent_discount)")
    .where("invoice_items.quantity >= discounts.quantity_threshold AND merchants.id = discounts.merchant_id")
    .group("invoice_items.item_id")
  end

  def total_discount_revenue
    discounts_total = 0
    find_discount.each do |highest_discount|
      discounts_total += highest_discount.max
    end
     discounts_total
  end


  def calculate_total_revenue_with_discounts
    # return total_revenue if find_discount.nil?
    total_revenue - total_discount_revenue
  end
end
