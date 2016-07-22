class DrugMovement < ActiveRecord::Base
  belongs_to :drug_in
  belongs_to :exam

  def amount
    self.prev_bal - self.balance
  end
end
