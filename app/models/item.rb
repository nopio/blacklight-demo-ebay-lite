class Item < ActiveRecord::Base
  validates :title, :description, :price, :category_id, :brand_id,
            :condition, :format, :screen_size, :color, :memory, presence: true

  enum category_id: [:notebook, :ultrabook, :netbook]
  enum brand_id: [:apple, :lenovo, :dell, :hp, :asus]
  enum color: [:white, :black, :silver, :gold]
  enum format: [:buy_now, :auction]
  enum condition: [:brand_new, :used, :refurbished]

  attr_accessor :skip

  after_commit :index_data_in_solr, on: [:create, :update], unless: :skip_indexing?
  before_destroy :remove_data_from_solr

  MEMORY_SIZES = 2.upto(8).each_with_object({}) { |item, hash| hash[item] = "#{item}GB" }
  SCREEN_SIZES  = %w(11.6 13.3 14 15.4).each_with_object({}) { |item, hash| hash[item] = "#{item} inches"}

  def to_solr
    {
      "title" => title, "description" => description, "price" => price, "category" => category_id.titleize,
      "brand" => brand_id.titleize, "condition" => condition.titleize, "format" => format.titleize,
      "screen_size" => "#{screen_size} inches", "color" => color.titleize, "memory" => "#{memory}GB", "id" => id
    }
  end
  
  def skip_indexing?
    skip_indexing
  end

  def index_data_in_solr
    SolrService.add(to_solr)
    SolrService.commit
  end

  def remove_data_from_solr
    SolrService.delete_by_id(id)
    SolrService.commit
  end
end
