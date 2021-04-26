require 'rails_helper'

RSpec.describe "Create New Discounts" do
  describe "As a mercahnt, I am taken to a new Page" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Wellness')

      visit new_merchant_discount_path(@merchant1)
    end

    it "shows a user form to create a new bulk discount and creates it" do

      expect(page).to have_content("Create New Discount")

      fill_in("percent_discount", with: 0.1)
      fill_in("quantity_threshold", with: 20)

      click_button("Create Discount")

      expect(page).to have_current_path(merchant_discounts_path(@merchant1))
      expect(page).to have_content("#{@merchant1.discounts.first.percent_discount}% off when you buy #{@merchant1.discounts.first.quantity_threshold} items.")
    end

    it 'if user fills in invalid/no data into the form, it doesnt create the discount' do

      click_button("Create Discount")
      expect(page).to have_content('Missing Fields')
    end
  end
end
