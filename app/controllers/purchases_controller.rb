class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def new
    @categories = current_user.categories
    @category = @categories.select { |i| i.id == params[:category_id].to_i }[0]
    @purchase = Purchase.new
  end

  def create
    @category = Category.find(params[:category_id])
    @purchase = Purchase.new(purchase_params)
    @purchase.author = current_user

    if @purchase.save
      redirect_to category_path(@category), notice: 'Your purchase is added successfully 🎉'
    else
      error = @purchase.errors.full_messages[0]
      redirect_to new_category_purchase_path(@category), notice: "#{error} Please try again."
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    redirect_back(fallback_location: authenticated_root_path, notice: 'Purchase item has been removed')
  end

  private

  def purchase_params
    params.require(:purchase).permit(:name, :amount, category_ids: [])
  end
end
