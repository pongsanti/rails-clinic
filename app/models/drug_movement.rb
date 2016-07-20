class DrugMovement < ActiveRecord::Base
  belongs_to :drug_in
  belongs_to :exam
end
