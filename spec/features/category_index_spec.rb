require 'rails_helper'

RSpec.feature 'Categories Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'Raihan', email: 'raihan1@gmail.com', password: 'password', confirmed_at: Time.now) }
  let!(:category1) { Category.create!(author: user, name: 'Food', icon: '🍔') }
  let!(:category2) { Category.create!(author: user, name: 'Car', icon: '🚗') }

  before do
    sign_in user
    visit categories_path
  end

  scenario 'User can see names of all categories' do
    expect(page).to have_content(category1.name)
    expect(page).to have_content(category2.name)
  end

  scenario 'User can see icons of all categories' do
    expect(page).to have_content(category1.icon)
    expect(page).to have_content(category2.icon)
  end

  scenario 'User can see total amount of each category' do
    expect(page).to have_content(category1.total_amount)
    expect(page).to have_content(category2.total_amount)
  end

  scenario 'User can navigate to transactions page' do
    click_link category1.name
    expect(current_path).to eq category_path(category1)
  end

  scenario 'User can navigate to category/new page' do
    click_link 'Add Category'
    expect(current_path).to eq new_category_path
  end
end
