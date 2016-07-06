json.array!(@drug_ins) do |drug_in|
  json.extract! drug_in, :id, :amount, :expired_date, :cost, :sale_price_per_unit, :balance, :drug_id
  json.url drug_in_url(drug_in, format: :json)
end
