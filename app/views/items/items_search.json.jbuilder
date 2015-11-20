json.array!(@found_elements) do |element|
  json.id element.id
  json.name element.typeahead_format
  if element.class.to_s == 'User'
  	json.url user_profile_path(element.id)
  else
  	json.url item_path(element.id)
  end
end
