class Drug < ActiveRecord::Base

  ID_PREFIX = "D"

  acts_as_paranoid

  belongs_to :drug_usage
  belongs_to :store_unit

  has_many :drug_ins

  validates :name, presence: true

  class << self
    # searchable fields
    def ransackable_attributes(auth_object = nil)
    #column_names + _ransackers.keys
      %w(name trade_name)
    end

    def drug_ins_exist()
      joins(:drug_ins).where("drug_ins.drug_id is not null").distinct.order("name")
    end

  end

  def recal_balance
    self.update( {balance: self.drug_ins.sum(:balance)} )
  end
end
