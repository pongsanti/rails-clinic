class Amount
  include ActiveModel::Model

  attr_accessor :amount

  validates :amount, presence: true
  
end