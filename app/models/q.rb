class Q < ActiveRecord::Base

  ID_PREFIX = "Q"

  belongs_to :exam

  scope :cat_is, -> (c) { where("category = ?", c ) }

end
