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

  def discount_amount
  end

  def total_revenue_with_discount
  end

  def has_discount?(invoice_item_id)
    return 'no_discount' if percent_discount(invoice_item_id) == 0
    'discount'
  end
end
