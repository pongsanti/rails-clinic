class Drug < ActiveRecord::Base

  belongs_to :drug_usage
  belongs_to :store_unit

  has_many :drug_ins


  class << self
    # searchable fields
    def ransackable_attributes(auth_object = nil)
    #column_names + _ransackers.keys
      %w(name trade_name)
    end

  end

end
