json.array!(@diags) do |diag|
  json.extract! diag, :id, :name, :description
  json.url diag_url(diag, format: :json)
end
