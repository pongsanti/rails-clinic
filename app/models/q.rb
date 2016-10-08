class Q < ActiveRecord::Base

  ID_PREFIX = "Q"

  EXAM_Q_CAT = "A"
  MED_Q_CAT = "B"

  belongs_to :exam, inverse_of: :qs

  validates :exam, presence: true
  validates :category, inclusion: {in: [EXAM_Q_CAT, MED_Q_CAT]}, allow_blank: true

  class << self
    def cat_is(c)
      where("category = ?", c ).order("qs.id asc") 
    end

    def eager_cat_is(c)
      eager.where("category = ?", c ).order("qs.id asc")
    end

    def eager
      joins(exam: [customer: [:prefix ]]) 
        .includes(exam: [customer: [:prefix ]])
    end
  end

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
