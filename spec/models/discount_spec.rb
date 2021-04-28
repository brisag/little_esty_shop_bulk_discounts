require "rails_helper"

RSpec.describe Discount, type: :model do
  describe "validations" do
    it {should validate_numericality_of :percent_discount}
    it {should validate_numericality_of :quantity_threshold}
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

describe "instance methods" do
    it "#pending_invoices" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      # @merchant2 = Merchant.create!(name: 'Wellness')

      @discount_1 = Discount.create!(percent_discount: 0.10, quantity_threshold: 20, merchant_id: @merchant1.id)
      @discount_2 = Discount.create!(percent_discount: 0.30, quantity_threshold: 8, merchant_id: @merchant1.id)
      @discount_3 = Discount.create!(percent_discount: 0.50, quantity_threshold: 5, merchant_id: @merchant1.id)

      @holiday1 = HolidayService.next_three_holidays.first
      @holiday2 = HolidayService.next_three_holidays.second
      @holiday3 = HolidayService.next_three_holidays.third

      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
      @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
      @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 0, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 1)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 1)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)

      @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 1, created_at: "2012-03-28 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 10, status: 2)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)

      expect(@discount_1.pending_invoices.length).to eq 0
      expect(@discount_2.pending_invoices.length).to eq 1
    end
  end
end
