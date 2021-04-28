require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "When i visit the Discount Index Page" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Wellness')

      @discount_1 = Discount.create!(percent_discount: 0.10, quantity_threshold: 20, merchant_id: @merchant1.id)
      @discount_2 = Discount.create!(percent_discount: 0.30, quantity_threshold: 15, merchant_id: @merchant1.id)
      @discount_3 = Discount.create!(percent_discount: 0.50, quantity_threshold: 30, merchant_id: @merchant2.id)

      @holiday1 = HolidayService.next_three_holidays.first
      @holiday2 = HolidayService.next_three_holidays.second
      @holiday3 = HolidayService.next_three_holidays.third
      visit merchant_discounts_path(@merchant1)
    end

    it "can show all my bulk discounts with percentage discount and quantity thresholds" do

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

      within "#discount-#{@discount_1.id}" do
        expect(page).to have_link("Discount Info")
        click_link("Discount Info")

        expect(current_path).to eq(merchant_discount_path(@merchant1, @discount_1))
      end
    end

    describe "Link to create new merchant" do
      describe  "I see a link to create a new discount" do
        it "When i click on it, it takes to a form to fill out" do

          expect(page).to have_button('Create New Discount')
          click_on('Create New Discount')
          expect(current_path).to eq(new_merchant_discount_path(@merchant1))
        end
      end
    end

    describe "Delete Discount" do
      it "I see a link to Delete Discount" do

        within "#discount-#{@discount_1.id}" do
          expect(page).to have_button('Delete Discount')
        end

        within "#discount-#{@discount_2.id}" do
          expect(page).to have_button('Delete Discount')
        end
      end

      it "When i click on this link, i am redirected back to index page and i no longer see it on discoubnt page" do

        within "#discount-#{@discount_1.id}" do
          click_on('Delete Discount')
        end

        expect(current_path).to eq(merchant_discounts_path(@merchant1))

        expect(page).to_not have_content(@discount_1.id)
      end

      it 'a merchant cant delete a discount if there are pending invoice items on it ' do

        within "#discount-#{@discount_2.id}" do
          expect(page).to_not have_button("Delete Discount")
          expect(page).to have_content("This discount can't be edited or deleted because it has pending invoice items")
        end

        within "#discount-#{@discount_1.id}" do
          expect(page).to have_button("Delete Discount")
        end
      end
    end
  end
end
