json.array!(@drugs) do |drug|
  json.extract! drug, :id, :name, :trade_name, :effect, :balance, :drug_usage_id
  json.url drug_url(drug, format: :json)
end
