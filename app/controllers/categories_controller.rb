class CategoriesController < ApplicationController
  before_action :authenticate_user!

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

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.author = current_user

    if @category.save
      redirect_to categories_path, notice: 'New category has been created!'
    else
      error = @category.errors.full_messages[0]
      redirect_to new_category_path, notice: "#{error} Please try again."
    end
  end

  def edit
    @category = current_user.categories.find(params[:id])
  end

  def update
    @category = current_user.categories.find(params[:id])
    return unless @category.update(category_params)

    redirect_to category_path(@category), notice: "#{@category.name} has been updated"
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: 'Category has been deleted'
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
