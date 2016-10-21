class Order < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :description, presence: true
  validates :shipping_charge, presence: true
end
