class Discount < ApplicationRecord
  belongs_to :merchant
  validates :percent_discount, numericality: true
  validates :quantity_threshold, numericality: true
end
