class Exam < ActiveRecord::Base

  belongs_to :customer
  belongs_to :examiner, class_name: 'User'

  has_many :exams_diags
  has_many :diags, through: :exams_diags

  validates :weight, :height, :pulse, format: { with: /\A\d{1,3}(\.\d{1})?\z/ }, allow_blank: true
  validates :bp_systolic, :bp_diastolic, format: { with: /\A\d{1,3}\z/ }, allow_blank: true

  scope :customer_id_is, -> (cid) { where("customer_id = ?", cid)}

  def bmi
    result = "N/A"
    if weight.present? && height.present?
      result = weight / ((height / 100) ** 2)
      result = result.round(2)
    end
    result
  end

end
