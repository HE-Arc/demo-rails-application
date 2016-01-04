class Product < ActiveRecord::Base
  has_and_belongs_to_many :sizes

  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }
end
