class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories.includes(:purchases)
    @unique_purchases = current_user.purchases.joins(:categories).distinct
    @total_amount = @unique_purchases.map(&:amount).sum
  end
end
