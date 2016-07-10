class DrugIn < ActiveRecord::Base
  belongs_to :drug

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

end
