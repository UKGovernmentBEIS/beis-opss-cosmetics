class Product < ApplicationRecord
  include CountriesHelper
  include Documentable
  include Searchable

  index_name [Rails.env, "products"].join("_")

  default_scope { order(created_at: :desc) }

  has_many_attached :documents
  has_many_attached :images

  has_many :investigation_products, dependent: :destroy
  has_many :investigations, through: :investigation_products
  has_many :rapex_images, dependent: :destroy, inverse_of: :product # TODO MSPSDS-266: Remove once images are migrated

  has_one :source, as: :sourceable, dependent: :destroy

  accepts_nested_attributes_for :source

  has_paper_trail

  def as_indexed_json(*)
    as_json.merge(cases: investigations.size)
  end

  def country_of_origin_for_display
    country_from_code country_of_origin
  end

  def image_count
    images.attachments.size + rapex_images.size
  end
end

Product.import force: true # for auto sync model with elastic search
