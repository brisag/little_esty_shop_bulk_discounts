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
    describe "incomplete_invoices" do
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
      describe "Merchant A has one Bulk Discount, Discount A is 20% off 10 items, Invoice A includes two of Merchant A’s items" do
        describe "Item A is ordered in a quantity of 5, Item B is ordered in a quantity of 5" do
          it "doesnt apply any discounts" do
            merchant1 = Merchant.create!(name: 'Hair Care')
            discount1 = Discount.create!(percent_discount: 0.20, quantity_threshold: 10, merchant_id: merchant1.id)
            item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)
            item_1 = Item.create!(name: "Clip", description: "This holds up your hair but in a clip", unit_price: 10, merchant_id: merchant1.id)
            customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
            invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
            ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 5, unit_price: 10, status: 2)
            ii_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 5, unit_price: 10, status: 2)

            expect(ii_1.discount_threshold).to eq(nil)
            expect(ii_2.discount_threshold).to eq(nil)
          end
        end
      end

      describe "Merchant A has one Bulk Discount, Bulk Discount A is 20% off 10 items" do
        describe "Invoice A includes two of Merchant A’s items, Item A is ordered in a quantity of 10, Item B is ordered in a quantity of 5" do
          it "Item A should be discounted at 20% off. Item B should not be discounted." do
            merchant1 = Merchant.create!(name: 'Hair Care')
            discount1 = Discount.create!(percent_discount: 0.20, quantity_threshold: 10, merchant_id: merchant1.id)
            item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)
            item_1 = Item.create!(name: "Clip", description: "This holds up your hair but in a clip", unit_price: 10, merchant_id: merchant1.id)
            customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
            invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
            ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 10, unit_price: 10, status: 2)
            ii_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 5, unit_price: 10, status: 2)

            expect(ii_1.discount_threshold).to eq(discount1.id)
            expect(ii_2.discount_threshold).to eq(nil)
          end
        end
      end

      describe "Merchant A has two Bulk Discounts, Bulk Discount A is 20% off 10 items, Bulk Discount B is 30% off 15 items" do
        describe "Invoice A includes two of Merchant A’s items, Item A is ordered in a quantity of 12, Item B is ordered in a quantity of 15" do
          it "Both Item A and Item B should discounted at 20% off. B will not be applied" do
            merchant1 = Merchant.create!(name: 'Hair Care')
            discount1 = Discount.create!(percent_discount: 0.20, quantity_threshold: 10, merchant_id: merchant1.id)
            discount2 = Discount.create!(percent_discount: 0.15, quantity_threshold: 15, merchant_id: merchant1.id)

            item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)
            item_1 = Item.create!(name: "Clip", description: "This holds up your hair but in a clip", unit_price: 10, merchant_id: merchant1.id)
            customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
            invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
            ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 12, unit_price: 10, status: 2)
            ii_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 15, unit_price: 10, status: 2)

            expect(ii_1.discount_threshold).to eq(discount1.id)
            expect(ii_2.discount_threshold).to eq(discount1.id)
            expect(ii_1.discount_threshold).to_not eq(discount2.id)
            expect(ii_2.discount_threshold).to_not eq(discount2.id)
          end
        end
      end
    end
  end
end
