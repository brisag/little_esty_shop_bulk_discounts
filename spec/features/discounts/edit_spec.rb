RSpec.describe "As a visitor" do
  describe "When I go to the Discount Edit Page" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Jewlery')

      @discount_1 = Discount.create!(percent_discount: 0.10, quantity_threshold: 15, merchant_id: @merchant1.id)
      @discount_2 = Discount.create!(percent_discount: 0.20, quantity_threshold: 30, merchant_id: @merchant1.id)
      @discount_3 = Discount.create!(percent_discount: 0.30, quantity_threshold: 40, merchant_id: @merchant2.id)

      visit edit_merchant_discount_path(@merchant1, @discount_1)
    end

    it "it shows a form with prepopulated attributes" do
      expect(page).to have_field("percent_discount", :with => "0.1")
      expect(page).to have_field("quantity_threshold", :with => "15")
    end

    it "allows me to change any or all og the attributes and if i click submit, im redirected to show page with updates" do
      save_and_open_page
      fill_in("Change percent discount", with: 0.17)

      click_button("Edit Discount")

      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount_1))

      expect(page).to have_content("Discount percentage: 0.17, item quantity: 15")
    end
  end
end
