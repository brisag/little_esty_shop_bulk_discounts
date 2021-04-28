require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "When i visit the Discount Index Page" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      # @merchant2 = Merchant.create!(name: 'Wellness')

      @discount_1 = Discount.create!(percent_discount: 0.10, quantity_threshold: 20, merchant_id: @merchant1.id)
      @discount_2 = Discount.create!(percent_discount: 0.30, quantity_threshold: 15, merchant_id: @merchant1.id)
      @discount_3 = Discount.create!(percent_discount: 0.50, quantity_threshold: 30, merchant_id: @merchant1.id)

      @holiday1 = HolidayService.next_three_holidays.first
      @holiday2 = HolidayService.next_three_holidays.second
      @holiday3 = HolidayService.next_three_holidays.third

      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
      @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
      @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 1)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 1)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)

      @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 10, status: 2)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)

      # visit merchant_discounts_path(@merchant1)
    end

    it "can show all my bulk discounts with percentage discount and quantity thresholds" do
      visit merchant_discounts_path(@merchant1)

      expect(page).to have_content("#{@merchant1.name}'s Discounts")

      within "#discount-#{@discount_1.id}" do
        expect(page).to have_content(@discount_1.id)
        expect(page).to have_content("#{@discount_1.percent_discount}% off when you buy #{@discount_1.quantity_threshold} items.")
      end

      within "#discount-#{@discount_2.id}" do
        expect(page).to have_content(@discount_2.id)
        expect(page).to have_content("#{@discount_2.percent_discount}% off when you buy #{@discount_2.quantity_threshold} items.")
      end
    end

    describe "In the Holiday Discounts section" do
      it "I see Upcoming Holidays" do
        visit merchant_discounts_path(@merchant1)


        expect(page).to have_content("Upcoming Holidays")

        within "#holiday-#{@holiday1.date}" do
          expect(page).to have_content(@holiday1.name)
          expect(page).to have_content(@holiday1.date)
        end

        within "#holiday-#{@holiday2.date}" do
          expect(page).to have_content(@holiday2.name)
          expect(page).to have_content(@holiday2.date)
        end

        within "#holiday-#{@holiday3.date}" do
          expect(page).to have_content(@holiday3.name)
          expect(page).to have_content(@holiday3.date)
        end
      end
    end

    it 'each discount has a link to that merchant discounts show page' do
      visit merchant_discounts_path(@merchant1)


      within "#discount-#{@discount_1.id}" do
        expect(page).to have_link("Discount Info")
        click_link("Discount Info")

        expect(current_path).to eq(merchant_discount_path(@merchant1, @discount_1))
      end
    end

    describe "Link to create new merchant" do
      describe  "I see a link to create a new discount" do
        it "When i click on it, it takes to a form to fill out" do
          visit merchant_discounts_path(@merchant1)


          expect(page).to have_button('Create New Discount')
          click_on('Create New Discount')
          expect(current_path).to eq(new_merchant_discount_path(@merchant1))
        end
      end
    end

    describe "Delete Discount" do
      describe "I see a link to Delete Discount" do
        it "When i click on this link, i am redirected back to index page and i no longer see it on discoubnt page" do
          visit merchant_discounts_path(@merchant1)

          # save_and_open_page
          within "#discount-#{@discount_1.id}" do
            click_on('Delete Discount')
          end

          expect(current_path).to eq(merchant_discounts_path(@merchant1))

          expect(page).to_not have_content(@discount_1.id)
        end
      end

      # it 'a merchant cant delete a discount if there are pending invoice items on it ' do
      #   # save_and_open_page
      #   # binding.pry
      #   within "#discount-#{@discount_2.id}" do
      #     expect(page).to_not have_button("Delete Discount")
      #     expect(page).to have_content("When an invoice is pending, a merchant cannot be able to delete or edit a discount that applies to that invoice.")
      #   end
      #
      #   within "#discount-#{@discount_1.id}" do
      #     expect(page).to have_button("Delete Discount")
      #   end
      # end
    end
  end
end
