class DrugSerializer < ActiveModel::Serializer
  attributes :id, :name, :trade_name, :effect, :balance
  has_one :drug_usage
end
