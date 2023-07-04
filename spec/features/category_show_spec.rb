require 'rails_helper'

RSpec.feature 'Transactions Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'Raihan', email: 'raihan1@gmail.com', password: 'password', confirmed_at: Time.now) }
  let(:category) { Category.create!(author: user, name: 'Food', icon: '🍔') }
  let!(:purchase1) { Purchase.create!(author: user, name: 'Lunch', amount: 10, categories: [category]) }
  let!(:purchase2) { Purchase.create!(author: user, name: 'Dinner', amount: 20, categories: [category]) }

  before do
    sign_in user
    visit category_path(category)
  end

  scenario 'User can see the list of purchases' do
    expect(page).to have_content(purchase1.name)
    expect(page).to have_content(purchase2.name)
  end

  scenario 'User can see purchases ordered by most recent' do
    expect(page.all('.item-card').first).to have_content(purchase2.name)
    expect(page.all('.item-card').last).to have_content(purchase1.name)
  end

  scenario 'User can see total amount for the category' do
    expect(page).to have_content("$#{category.total_amount}.00")
  end

  scenario 'User can navigate to new transaction page' do
    click_link 'Add purchase'
    expect(current_path).to eq new_category_purchase_path(category)
  end
end
