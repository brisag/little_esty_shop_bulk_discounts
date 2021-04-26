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
    #use recursion since we get multiple rows of data
    discounts_total = 0
    # binding.pry
    find_discount.each do |row|
      discounts_total += row.max
    end
     discounts_total
  end


  def calculate_total_revenue_with_discounts
    total_revenue - total_discount_revenue
  end
end


# Invoice Class
#apply to invoice class directly instead.  no id needed

# def self.find_discount(id)
#   joins(merchant: :discounts).
#   select('invoice_items.*, discounts.percent_discount AS discount, discounts.id AS discount_id').
#   where("invoice_items.id = ? AND invoice_items.quantity >= discounts.quantity_threshold", id).
#   order('discounts.percent_discount DESC').
#   limit(1).first
# end
