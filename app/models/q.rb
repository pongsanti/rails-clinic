class Q < ActiveRecord::Base

  belongs_to :exam

  scope :type_is, -> (t) { where("type = ?", t ) }

end
