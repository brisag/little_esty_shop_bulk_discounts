class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :percent_discount, :quantity_threshold
  validates :percent_discount, numericality: true
  validates :quantity_threshold, numericality: true
end
