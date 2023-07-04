require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create!(name: 'Raihan', email: 'raihan1@gmail.com', password: 'password', confirmed_at: Time.now) }
  let(:category) { Category.create!(author: user, name: 'Food', icon: '🍔') }
  let(:purchase) { Purchase.create!(author: user, name: 'Lunch', amount: 10, categories: [category]) }

  describe 'validations' do
    it 'should valid with all valid attributes' do
      expect(category).to be_valid
    end

    it 'should not valid if name is not present' do
      category.name = nil
      expect(category).to_not be_valid
    end

    it 'should not valid if icon is not present' do
      category.icon = nil
      expect(category).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should belong to correct user' do
      expect(category.author).to eql user
    end

    it 'should include correct purchase' do
      expect(category.purchases).to include(purchase)
    end
  end
end
