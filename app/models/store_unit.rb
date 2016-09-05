class StoreUnit < ActiveRecord::Base
  
  ID_PREFIX = "SU"
  
  acts_as_paranoid
  
  paginates_per 10

end