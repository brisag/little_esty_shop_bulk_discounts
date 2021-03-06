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
      expect(find_field('percent_discount').value).to eq('0.1')
      expect(find_field('quantity_threshold').value).to eq('15')
    end

    it "allows me to change any or all og the attributes and if i click submit, im redirected to show page with updates" do
      # save_and_open_page
      fill_in("percent_discount", with: 0.17)
      fill_in("quantity_threshold", with: 15)

      click_button("Edit Discount")

      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount_1))
      # save_and_open_page
      expect(page).to have_content("Discount Percent: 0.17%")
      expect(page).to have_content("Quantity Threshold: 15 Items")

    end

    it 'when i enter invalid fields into the form it doesnt update the discount' do

      fill_in("percent_discount", with: "")
      fill_in("quantity_threshold", with: "")
      click_button("Edit Discount")

      expect(page).to have_content('Your Discount Was Not Saved')
    end
  end
end
