class StoreUnit < ActiveRecord::Base
  
  ID_PREFIX = "SU"
  
  paginates_per 10

end