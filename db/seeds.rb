name = ["MacBook Pro", "Lenovo Yeti", "MacBook Air", "HP Envy", "Lenovo ThinkPad", "ASUS ZenBook"]
categories = Item.category_ids.keys
brands = Item.brand_ids.keys
colors = Item.colors.keys
formats = Item.formats.keys
conditions = Item.conditions.keys
memories = Item::MEMORY_SIZES.keys
screens = Item::SCREEN_SIZES.keys

1.upto(200_000) do |a|
  color = colors.sample
  item = Item.new(title: "#{color.capitalize} #{name.sample}",
                  description: Faker::Lorem.sentence(3),
                  price: rand(2500),
                  category_id: categories.sample,
                  brand_id: brands.sample,
                  condition: conditions.sample,
                  format: formats.sample,
                  screen_size: screens.sample,
                  memory: memories.sample,
                  color: color)
  item.skip = true
  item.save
  SolrService.add(item.to_solr)
  print '.' if a % 10_000 == 0
end
SolrService.commit
