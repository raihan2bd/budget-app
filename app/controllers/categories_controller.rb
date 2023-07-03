class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories.includes(:purchases)
    @unique_purchases = current_user.purchases.joins(:categories).distinct
    @total_amount = @unique_purchases.map(&:amount).sum
  end

  def show
    @category = current_user.categories.includes(:purchases).find(params[:id])
    @purchases = @category.purchases.sort { |a, b| b.updated_at <=> a.updated_at }
    @total_amount = @purchases.map(&:amount).sum
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    flash[:success] = "#{@category.name} category has been deleted."
    redirect_to categories_path
  end
end
