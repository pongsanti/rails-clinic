class Q < ActiveRecord::Base

  ID_PREFIX = "Q"

  EXAM_Q_CAT = "A"
  MED_Q_CAT = "B"

  belongs_to :exam

  validates :exam, presence: true
  validates :category, inclusion: {in: [EXAM_Q_CAT, MED_Q_CAT]}, allow_blank: true

  scope :cat_is, -> (c) { where("category = ?", c ).order("id asc") }
  # includes essentials
  # Q includes exam, customer and prefix
  scope :inc_ess, -> { includes(:exam,
    exam: [customer: [:prefix] ] ) }

  def exam_q?
    self.category == EXAM_Q_CAT
  end

  def med_q?
    self.category == MED_Q_CAT
  end

  def switch_category
    self.category = (self.exam_q?) ? MED_Q_CAT : EXAM_Q_CAT
  end

end
