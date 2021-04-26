class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end




  # def discount
  #   discounts
  #   .where('? >= discounts.quantity_threshold', quantity)
  #   .order('discounts.percent_discount desc, discounts.quantity_threshold')
  #   .first
  # end

  def discount_threshold
    discounts
    .where('? >= quantity_threshold', self.quantity)
    .order(percent_discount: :desc)
    .pluck(:id)
    .first
  end
end

  # def applicable_discount
  #   discounts
  #   .where('? >= quantity_threshold', self.quantity)
  #   .order(discount: :desc, threshold: :desc)
  #   .pluck(:discount, :id)
  #   .first
  # end
