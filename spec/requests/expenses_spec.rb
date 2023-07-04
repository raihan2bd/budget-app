require 'rails_helper'

RSpec.describe 'Purchase', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'Raihan', email: 'raihan1@gmail.com', password: 'password', confirmed_at: Time.now) }
  let(:category) { Category.create!(author: user, name: 'Food', icon: '🍔') }
  let(:purchase) { Purchase.create!(author: user, name: 'Pizza', amount: 150, categories: [category]) }

  let(:valid_params) { { category_ids: [category.id], name: 'Burger', amount: 100 } }
  let(:invalid_params) { { category_ids: [], name: 'Burger', amount: 100 } }

  before do
    sign_in user
  end

  describe 'GET /new' do
    it 'should return a 200 OK status' do
      get new_category_purchase_path(category)
      expect(response).to have_http_status(:ok)
    end

    it 'should render purchases/new template' do
      get new_category_purchase_path(category)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'should create a new purchase' do
        expect do
          post category_purchases_path(category), params: { purchase: valid_params }
        end.to change(Purchase, :count).by(1)
      end

      it 'should redirect to corresponding categories/show page' do
        post category_purchases_path(category), params: { purchase: valid_params }
        expect(response).to redirect_to(category_path(category))
      end
    end

    context 'with invalid parameters' do
      it 'should not create a new purchase' do
        expect do
          post category_purchases_path(category), params: { purchase: invalid_params }
        end.to change(Purchase, :count).by(0)
      end

      it 'should redirect to purchases/new page' do
        post category_purchases_path(category), params: { purchase: invalid_params }
        expect(response).to redirect_to(new_category_purchase_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'should destroy the requested purchase' do
      new_purchase = Purchase.create!(author: user, categories: [category], name: 'Sushi', amount: 30)
      expect do
        delete category_purchase_path(category, new_purchase)
      end.to change(Purchase, :count).by(-1)
    end
  end
end
