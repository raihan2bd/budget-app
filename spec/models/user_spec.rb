require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: 'Raihan', email: 'raihan1@gmail.com', password: 'password', confirmed_at: Time.now) }

  describe 'validations' do
    it 'should valid with all valid attributes' do
      expect(user).to be_valid
    end

    it 'should not valid if name is not present' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'should not valid if email is not present' do
      user.email = nil
      expect(user).to_not be_valid
    end
  end

  describe 'authentication' do
    it 'should have email and password columns' do
      columns = User.column_names
      expect(columns).to include('email', 'encrypted_password')
    end

    it 'should validate the password' do
      expect(user.valid_password?('password')).to eql true
      expect(user.valid_password?('wrong_password')).to eql false
    end
  end
end
