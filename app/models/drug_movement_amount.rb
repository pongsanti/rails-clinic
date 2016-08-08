class DrugMovementAmount
  include ActiveModel::Model

  attr_accessor :amount, :exam_id

  validates :amount, presence: true, numericality: true
  validates :exam_id, presence: true
  
end