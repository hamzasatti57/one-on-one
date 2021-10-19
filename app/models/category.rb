class Category < ApplicationRecord
  has_many :users
  has_many :sub_categories, class_name: "Category",
           foreign_key: "parent_id"

  has_many :product_categories
  belongs_to :parent, class_name: "Category", optional: true
  has_one_attached :image

  enum category_type: {
    "Featured" => 1,
    "Popular" => 2,
    "New" => 3
  }
end
