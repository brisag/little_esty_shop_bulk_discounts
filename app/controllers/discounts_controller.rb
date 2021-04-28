class DiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_discount, only: [:show, :edit, :update, :destroy]

  def index
    @holidayservices = HolidayService.next_three_holidays
  end

  def show
    # binding.pry
  end

  def new
    @discount = Discount.new
  end

  def create
    discount = @merchant.discounts.new(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      flash[:error] = "Missing Fields"
      render :new
    end
  end


  def edit
  end

  def update
    @discount.update(discount_params)
    if @discount.save
      redirect_to merchant_discount_path(@merchant, @discount)
    else
      flash[:error] = "Your Discount Was Not Saved"
      render :edit
    end
  end

  def destroy
    Discount.destroy(params[:id])
    redirect_to merchant_discounts_path(@merchant)
  end

  private

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_discount
    @discount = Discount.find(params[:id])
  end

  def discount_params
    params.permit(:percent_discount, :quantity_threshold)
  end
end
