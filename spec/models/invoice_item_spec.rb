require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end
  describe "Instance Methods" do
    describe "discount_threshold" do
      it "find incomplete invoices" do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @discount1 = Discount.create!(percent_discount: 0.20, quantity_threshold: 3, merchant_id: @merchant1.id)
        @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @item_1 = Item.create!(name: "Clip", description: "This holds up your hair but in a clip", unit_price: 10, merchant_id: @merchant1.id)
        @item_2 = Item.create!(name: "Item", description: "Some description", unit_price: 15, merchant_id: @merchant1.id)
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1, created_at: "2012-03-27 14:54:09")

        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 0)
        @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
        @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 3, unit_price: 10, status: 0)
        # binding.pry
        expect(InvoiceItem.incomplete_invoices).to eq([@invoice_1])

      end
    end
  end



  describe "Instance Methods" do
    describe "incomplete_invoices" do
      it "Finds if the discount is being applied to those that meet quanity threshold" do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @merchant2 = Merchant.create!(name: 'Jewlery')

        @discount1 = Discount.create!(percent_discount: 0.20, quantity_threshold: 3, merchant_id: @merchant1.id)
        @discount2 = Discount.create!(percent_discount: 0.50, quantity_threshold: 14, merchant_id: @merchant2.id)

        @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        @item_1 = Item.create!(name: "Clip", description: "This holds up your hair but in a clip", unit_price: 10, merchant_id: @merchant1.id)
        @item_2 = Item.create!(name: "Item", description: "Some description", unit_price: 15, merchant_id: @merchant1.id)

        @item_10 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant2.id)
        @item_11 = Item.create!(name: "Clip", description: "This holds up your hair but in a clip", unit_price: 10, merchant_id: @merchant2.id)
        @item_12 = Item.create!(name: "Item", description: "Some description", unit_price: 15, merchant_id: @merchant2.id)

        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

        @customer_2 = Customer.create!(first_name: 'James', last_name: 'John')
        @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 2, created_at: "2012-03-27 14:54:09")

        @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 2)
        @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 2)
        @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 3, unit_price: 10, status: 2)

        @ii_21 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_10.id, quantity: 10, unit_price: 10, status: 2)
        @ii_22 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_11.id, quantity: 15, unit_price: 10, status: 2)
        @ii_23 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_12.id, quantity: 20, unit_price: 10, status: 2)

        expect(@ii_1.discount_threshold).to eq(nil)
        expect(@ii_2.discount_threshold).to eq(nil)
        expect(@ii_3.discount_threshold).to eq(@discount1.id)
        # binding.pry
        expect(@ii_21.discount_threshold).to eq(nil)
        expect(@ii_22.discount_threshold).to eq(@discount2.id)
        expect(@ii_23.discount_threshold).to eq(@discount2.id)
      end
    end
  end
end
