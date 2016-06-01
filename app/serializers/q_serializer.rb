class QSerializer < ActiveModel::Serializer
  
  class QExamSerializer < ActiveModel::Serializer

    class ExamCustomerSerializer < ActiveModel::Serializer
      attributes :id, :name, :surname, :id_card_no
    end

    attributes :id
    has_one :customer, serializer: ExamCustomerSerializer
  end

  attributes :id, :category, :created
  has_one :exam, serializer: QExamSerializer

  def created
    object.created_at.to_s :time
  end

end