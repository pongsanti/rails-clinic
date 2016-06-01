class Q < ActiveRecord::Base

  belongs_to :exam

  scope :cat_is, -> (c) { where("category = ?", c ) }

end
