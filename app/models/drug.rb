class Drug < ActiveRecord::Base

  ID_PREFIX = "D"

  acts_as_paranoid

  paginates_per 10

  belongs_to :drug_usage
  belongs_to :store_unit

  has_many :drug_ins, inverse_of: :drug

  validates :name, presence: true

  class << self
    # searchable fields
    def ransackable_attributes(auth_object = nil)
    #column_names + _ransackers.keys
      %w(id name trade_name)
    end

    def drug_ins_exist()
      joins(:drug_ins).where("drug_ins.drug_id is not null").distinct.includes(:drug_ins).order("name")
    end

    def drug_with_drug_ins(did)
      includes(:drug_ins, :drug_usage, :store_unit).find(did)
    end

  end

  def recal_balance
    self.update( {balance: self.drug_ins.sum(:balance)} )
  end

  def unit
    store_unit.present? ? store_unit.title : I18n.t("default_unit")
  end

  def usage
    drug_usage.present? ? drug_usage.code_text : ""
  end

end
