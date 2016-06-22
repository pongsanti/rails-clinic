json.array!(@store_units) do |store_unit|
  json.extract! store_unit, :id, :title
  json.url store_unit_url(store_unit, format: :json)
end
