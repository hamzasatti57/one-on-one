class Checkout < ApplicationRecord
  belongs_to :billing_address
  belongs_to :user
  belongs_to :user_cart, optional: true

  validates :user_cart_id, uniqueness: true, allow_blank: true

end
