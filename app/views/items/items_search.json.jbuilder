json.array!(@found_items) do |item|
  json.id item.id
  json.name item.search_name
end
