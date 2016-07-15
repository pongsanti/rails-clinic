class DrugMovement < ActiveRecord::Base
  belongs_to :movable, polymorphic: true
end
