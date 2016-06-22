class Drug < ActiveRecord::Base

  belongs_to :drug_usage
  belongs_to :store_unit

end
