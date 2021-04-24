class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])

  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.discounts.new(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      flash[:error] = "Missing Fields"
      render :new
    end
  end

  def show
    # binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  private
  def discount_params
    params.permit(:percent_discount, :quantity_threshold)
  end
end
