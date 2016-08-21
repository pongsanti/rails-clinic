class DrugSerializer < ActiveModel::Serializer
  attributes :id, :name, :trade_name, :effect, :balance
  has_one :drug_usage
  has_one :store_unit
end
