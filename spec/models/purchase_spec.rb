require 'rails_helper'

RSpec.describe Purchase, type: :model do
  let(:user) { User.create!(name: 'Raihan', email: 'raihan1@gmail.com', password: 'password', confirmed_at: Time.now) }
  let(:category) { Category.create!(author: user, name: 'Food', icon: '🍔') }
  let(:purchase) { Purchase.create!(author: user, name: 'Dinner', amount: 15, categories: [category]) }

  describe 'validations' do
    it 'should not valid if name is not present' do
      purchase.name = nil
      expect(purchase).to_not be_valid
    end

    it 'should not valid if amount is not present' do
      purchase.amount = nil
      expect(purchase).to_not be_valid
    end

    it 'should not valid if amount is negative' do
      purchase.amount = -100
      expect(purchase).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should include at least one category' do
      expect(purchase.categories).to include(category)
    end
  end
end
