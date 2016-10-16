class DrugMovement < ActiveRecord::Base

  ID_PREFIX = "MM"

  attr_accessor :amount

  belongs_to :drug_in, inverse_of: :drug_movements
  belongs_to :patient_drug
  has_one :drug, through: :drug_in

  validates :amount, presence: true, numericality: true
  validates :drug_in, presence: true

  paginates_per 15

  class << self

    def for_drug_in(drug_in)
      where("drug_in_id = ?", drug_in).includes(
        :drug_in, :drug, :patient_drug)
    end
    
    def ransackable_scopes(auth_object = nil)
      %i(for_drug_in)
    end

  end

  def bal_diff
    self.balance - self.prev_bal
  end
end
