require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "When i visit the Discount Index Page" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Body Care')

      @discount_1 = Discount.create!(percent_discount: 10, quantity_threshold: 10, merchant_id: @merchant1.id)
      @discount_2 = Discount.create!(percent_discount: 25, quantity_threshold: 20, merchant_id: @merchant1.id)
      @discount_3 = Discount.create!(percent_discount: 50, quantity_threshold: 30, merchant_id: @merchant2.id)

      visit merchant_discounts_path(@merchant1)
    end

    it "can show all my bulk discounts with percentage discount and quantity thresholds" do

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

      # within "#discount-#{@discount_2.id}" do
      #   expect(page).to have_link("Discount")
      #   click_link("Discount")
      #
      #   expect(current_path).to eq(merchant_discount_path(@merchant1, @discount_2))
      # end
    end
  end
end
