require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "When I visit Bulk Discount Show Page" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Jewlery')

      @discount_1 = Discount.create!(percent_discount: 10, quantity_threshold: 15, merchant_id: @merchant1.id)
      @discount_2 = Discount.create!(percent_discount: 20, quantity_threshold: 30, merchant_id: @merchant1.id)
      @discount_3 = Discount.create!(percent_discount: 30, quantity_threshold: 40, merchant_id: @merchant2.id)

      visit merchant_discount_path(@merchant1, @discount_1)
    end

    it "I see the bulk discount's quantity threshold and percentage discount" do
      # save_and_open_page
      expect(page).to_not have_content("#{@discount_1.percent_discount}% off when you buy #{@discount_1.quantity_threshold} items.")
      expect(page).to have_no_content("20")
      expect(page).to have_no_content("30")

    end

    # it "shows a link to edit the bulk discount" do
    #   visit merchant_discount_path(@merchant1, @discount_1)
    #
    #   expect(page).to have_link("Edit Discount")
    # end
  end
end
