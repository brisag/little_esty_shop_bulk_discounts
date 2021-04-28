class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  validates :percent_discount, numericality: true
  validates :quantity_threshold, numericality: true

  # def pending_invoices
  #   invoice_items.where(status: 1)
  # end

  # def pending_invoices
  #   invoice_items
  #   .where(status: 1)
  #   .where('quantity >= ?', self.quantity_threshold)
  # end
  #
  # def pending_invoices_view_logic
  #   return "edit_delete" if pending_invoices.empty?
  #   "message"
  # end
end
