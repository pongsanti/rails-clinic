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
      # workaround for ransack bug
      # https://github.com/activerecord-hackery/ransack/issues/593
      did = 1 if did == true

      where("drug_in_id = ?", did)
    end
    
    def ransackable_scopes(auth_object = nil)
      %i(for_drug_in)
    end

  end

  def bal_diff
    self.balance - self.prev_bal
  end
end
