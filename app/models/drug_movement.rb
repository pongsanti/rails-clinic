class DrugMovement < ActiveRecord::Base

  attr_accessor :amount

  belongs_to :drug_in
  belongs_to :exam, inverse_of: :drug_movements

  validates :amount, presence: true, numericality: true
  validates_presence_of :drug_in # must have
  validates_presence_of :exam, if: "self.exam_id.present?"


  def bal_diff
    self.prev_bal - self.balance
  end


  def create_movement_for_drug_out(amount, exam_id = nil)
    drug_in = self.drug_in

    latest_bal = self.drug_movements.last.balance
    balance = latest_bal - BigDecimal.new(amount)
    self.drug_movements.build({balance: balance, prev_bal: latest_bal, exam_id: exam_id})
    self.balance = balance
  end
end
