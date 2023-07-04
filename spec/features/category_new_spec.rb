require 'rails_helper'

RSpec.feature 'New Category Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'Raihan', email: 'raihan1@gmail.com', password: 'password', confirmed_at: Time.now) }

  before do
    sign_in user
    visit new_category_path
  end

  scenario 'User can create a new category' do
    fill_in 'Name', with: 'Home'
    select '🏠', from: 'Icon'
    click_button 'Create Category'

    expect(current_path).to eq categories_path
    expect(page).to have_content('New category has been created!')
  end

  scenario 'User can see an error message if something wrong' do
    fill_in 'Name', with: nil
    select '🍔', from: 'Icon'
    click_button 'Create Category'

    expect(current_path).to eq new_category_path
    expect(page).to have_content "Name can't be blank"
  end
end
