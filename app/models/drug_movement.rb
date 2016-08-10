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
end
