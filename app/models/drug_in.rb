class DrugIn < ActiveRecord::Base
  belongs_to :drug
  has_many :drug_movements

  paginates_per 10

  class << self
    #scope
    def for_drug(drug_id)
      # workaround for ransack bug
      # https://github.com/activerecord-hackery/ransack/issues/593
      drug_id = 1 if drug_id == true

      where("drug_id = ?", drug_id)
    end

    def ransackable_scopes(auth_object = nil)
      %i(for_drug)
    end
  end

  def create_movement_for_new_drug_in(amount)
    self.drug_movements.build({balance: amount, prev_bal: 0})
    self.balance = amount
  end

  def create_movement_for_drug_out(amount, exam_id = nil)
    latest_bal = self.drug_movements.last.balance
    balance = latest_bal - BigDecimal.new(amount)
    self.drug_movements.build({balance: balance, prev_bal: latest_bal, exam_id: exam_id})
    self.balance = balance
  end
end