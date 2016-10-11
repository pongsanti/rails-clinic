class Appointment < ActiveRecord::Base
  ID_PREFIX = "AP"

  belongs_to :exam, inverse_of: :appointments, touch: true

  #kaminari
  paginates_per 10

  validates :date, presence: true
  validates :exam, presence: true
end
