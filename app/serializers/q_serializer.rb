class QSerializer < ActiveModel::Serializer
  
  class QExamSerializer < ActiveModel::Serializer

    class ExamCustomerSerializer < ActiveModel::Serializer
      attributes :id, :name, :surname, :id_card_no
    end

    attributes :id
    has_one :customer, serializer: ExamCustomerSerializer
  end

  attributes :id, :category, :created_at
  has_one :exam, serializer: QExamSerializer

end