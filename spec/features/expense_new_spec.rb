require 'rails_helper'

RSpec.feature 'New purchase Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Raihan', email: 'raihan1@gmail.com', password: 'password', confirmed_at: Time.now) }
  let!(:category) { Category.create!(author: user, name: 'Food', icon: '🍔') }
  let!(:purchase) { Purchase.create!(author: user, name: 'Lunch', amount: 10, categories: [category]) }

  before do
    sign_in user
    visit new_category_purchase_path(category)
  end

  scenario 'User can create a new purchase' do
    fill_in 'Name', with: 'Lunch'
    fill_in 'Amount', with: 50
    check 'Food'
    click_button 'Add Purchase'

    expect(current_path).to eq category_path(category)
    expect(page).to have_content('Your purchase is added successfully 🎉')
  end

  scenario 'User can see an error message if something wrong' do
    fill_in 'Name', with: nil
    check 'Food'
    click_button 'Add Purchase'

    expect(current_path).to eq new_category_purchase_path(category)
    expect(page).to have_content "Name can't be blank"
  end
end
