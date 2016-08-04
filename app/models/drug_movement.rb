class DrugMovement < ActiveRecord::Base
  belongs_to :drug_in
  belongs_to :exam

  validates_presence_of :drug_in # must have
  validates_presence_of :exam, if: "self.exam_id.present?"

  def amount
    self.prev_bal - self.balance
  end
end
