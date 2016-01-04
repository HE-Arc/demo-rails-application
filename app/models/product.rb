class Product < ActiveRecord::Base
  has_and_belongs_to_many :sizes

  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }

  has_attached_file :image, styles: { medium: '500x500', thumb: '250x250' },
                            default_url: '/images/:style/missing.png'

  validates_attachment_content_type :image, content_type: /^image\/.*$/
end
