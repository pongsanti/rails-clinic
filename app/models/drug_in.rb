class DrugIn < ActiveRecord::Base

  ID_PREFIX = "LT"

  acts_as_paranoid

  attr_accessor :amount

  belongs_to :drug, inverse_of: :drug_ins
  has_many :drug_movements, inverse_of: :drug_in

  paginates_per 10

  validates :drug, presence: true
  validates :amount, presence: true, numericality: true, on: :create
  validates :cost, :sale_price_per_unit, numericality: true, allow_blank: true

  class << self
    #scope
    def for_drug(drug)
      where("drug_id = ?", drug).includes(:drug)
    end
  end

  def create_movement_for_new_drug_in()
    self.drug_movements.build({balance: self.amount, prev_bal: 0, amount: 0})
    self.balance = self.amount
  end

  def create_movement_for_drug_out(drug_movement)
    latest_bal = self.drug_movements.last.balance
    balance = latest_bal + BigDecimal.new(drug_movement.amount)

    drug_movement.prev_bal = latest_bal
    drug_movement.balance = balance

    self.balance = balance
    self.drug_movements << drug_movement
  end
end