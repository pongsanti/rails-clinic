class ExamSerializer < ActiveModel::Serializer
  
  class ExamCustomerSerializer < ActiveModel::Serializer
    attributes :id, :name, :surname, :id_card_no
  end

  attributes :id, :phase, :created_at
  has_one :customer, serializer: ExamCustomerSerializer
end