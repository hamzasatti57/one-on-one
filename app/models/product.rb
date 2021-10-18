class Product < ApplicationRecord

  # has_many :punches, as: :punchable, dependent: :destroy
  has_many_attached :images
  has_one_attached :default_image
  belongs_to :product_category, optional: true
  belongs_to :product_type, optional: true
  belongs_to :company, optional: true
  has_many :user_cart_products, dependent: :destroy
  has_many :users, through: :user_cart_products
  # belongs_to :user, through: :company
  # has_many :user, through: :company
  # has_and_belongs_to_many :colors
  has_many :product_colors, dependent: :destroy
  has_many :colors, through: :product_colors
  has_many :comments, class_name: "Comment", foreign_key: "parent_id"
  has_many :ratings, class_name: "Rating", foreign_key: "parent_id"
  has_many :likes, class_name: "Like", foreign_key: "parent_id"

  validates :code, uniqueness: true, on: :create
  # acts_as_punchable
  scope :search_filter, -> (product_category_id) {
    filters = {}
    # price_range = price_range.split(',').map{ |s| s.to_f }
    filters[:product_category_id] = product_category_id if product_category_id != ""
    # filters[:product_type_id] = product_type_id if product_type_id != ""
    # filters[:price] = price_range.first..price_range.last
    where(filters)
  }
  enum assembly_type: {assembled: 0, free_assembly: 1, diy: 2}

  def add_colors color_ids
    if color_ids.present?
      colors = Color.where(id: color_ids)
      colors.to_a.each do |color|
        ProductColor.create!(color_id: color.id, product_id: self.id, inventory: self.inventory)
      end
    end
  end

  def update_colors color_ids
    self.colors.destroy_all
    if color_ids.present?
      colors = Color.where(id: color_ids)
      colors.to_a.each do |color|
        @product_color = ProductColor.where(color_id: color.id, product_id: self.id)
        if @product_color.present?
          @product_color.update!(inventory: self.inventory)
        else
          ProductColor.create!(color_id: color.id, product_id: self.id, inventory: self.inventory)
        end
      end
    end
  end

  def user
    self.company.user
  end
  scope :search, -> (q, location) {
    if q && location
      profiles = Profile.where('lower(address) LIKE ?', "%#{location.downcase}%")
      if profiles.any?
        users = User.where(id: profiles.pluck(:user_id))
        companies = Company.where(user_id: users.ids)
        where("company_id IN (?) AND lower(title) LIKE ?", companies.ids, "%#{q.downcase}%")
      else
        where('lower(title) LIKE ?', "%#{q.downcase}%")
      end
    else
      []
    end
  }


end
