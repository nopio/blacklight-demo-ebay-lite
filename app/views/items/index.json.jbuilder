json.array!(@items) do |item|
  json.extract! item, :id, :title, :category_id, :description, :condition, :price, :format, :brand_id, :screen_size, :color, :memory
  json.url item_url(item, format: :json)
end
