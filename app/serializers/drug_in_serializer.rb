class DrugInSerializer < ActiveModel::Serializer
  attributes :id, :amount, :expired_date, :cost, :sale_price_per_unit, :balance
  has_one :drug
end
