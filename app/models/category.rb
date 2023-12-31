class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :purchases, dependent: :destroy

  validates :name, presence: true
  validates :icon, presence: true

  def total_amount
    purchases.sum(:amount)
  end
end
