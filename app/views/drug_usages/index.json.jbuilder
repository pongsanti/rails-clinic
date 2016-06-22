json.array!(@drug_usages) do |drug_usage|
  json.extract! drug_usage, :id, :code, :text
  json.url drug_usage_url(drug_usage, format: :json)
end
