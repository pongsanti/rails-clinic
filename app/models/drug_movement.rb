class DrugMovement < ActiveRecord::Base

  ID_PREFIX = "MM"

  attr_accessor :amount

  belongs_to :drug_in, inverse_of: :drug_movements
  belongs_to :exam, inverse_of: :drug_movements

  validates :amount, presence: true, numericality: true
  validates :drug_in, presence: true
  validates :exam, presence: true, if: "self.exam_id.present?"

  paginates_per 15

  class << self

    def for_drug_in(did)
      where("drug_in_id = ?", did)
    end
    
  end

  def bal_diff
    self.prev_bal - self.balance
  end
end
