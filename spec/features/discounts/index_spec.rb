require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "When i visit the Discount Index Page" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Jewelry')

      @discount_1 = Discount.create!(percent_discount: 10, quantity_threshold: 10, merchant_id: @merchant1.id)
      @discount_2 = Discount.create!(percent_discount: 25, quantity_threshold: 20, merchant_id: @merchant1.id)
      @discount_3 = Discount.create!(percent_discount: 50, quantity_threshold: 30, merchant_id: @merchant2.id)

      visit merchant_discounts_path(@merchant1)
    end

    it "can show all my bulk discounts with percentage discount and quantity thresholds" do
      # save_and_open_page
      expect(page).to have_content("#{@discount_1.percent_discount}% off when you buy #{@discount_1.quantity_threshold} items.")
      expect(page).to have_content("#{@discount_2.percent_discount}% off when you buy #{@discount_2.quantity_threshold} items.")
    end

    it "shows a link for each bulk discount displayed" do
      # save_and_open_page
      within "#discount-#{@discount_1.id}" do
        expect(page).to have_link("Discount")
        click_link("Discount")

        expect(current_path).to eq(merchant_discount_path(@merchant1, @discount_1))
      end
    end

    describe "Link to create new merchant" do
      it "I see a link to create a new discount" do
        expect(page).to have_link("Create New Discount")
      end

      it "takes me  to a form to create new discount" do
        expect(page).to have_link("Create New Discount")
        click_link "Create New Discount"

        expect(current_path).to eq(new_merchant_discount_path(@merchant1))
      end
    end

    describe "I see a link to Delete Discount" do
      it "When i click on this link, i am redirected back to index page and i no longer see it on discoubnt page" do
        save_and_open_page
        within "#discount-#{@discount_1.id}" do
          expect(page).to have_link("Delete Discount")
          click_link("Delete Discount")

          expect(current_path).to eq(merchant_discounts_path(@merchant1))
          expect(page).to_not have_content("#{@discount_1.percent_discount}% off when you buy #{@discount_1.quantity_threshold} items.")
          expect(page).to have_content("#{@discount_2.percent_discount}% off when you buy #{@discount_2.quantity_threshold} items.")
        end
      end
    end
  end
end
