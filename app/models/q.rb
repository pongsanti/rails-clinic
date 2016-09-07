class Q < ActiveRecord::Base

  ID_PREFIX = "Q"

  belongs_to :exam

  validates :exam, presence: true
  validates :category, inclusion: {in: %w(B A)}, allow_blank: true

  scope :cat_is, -> (c) { where("category = ?", c ) }

end
