class Exam < ActiveRecord::Base

  belongs_to :customer
  belongs_to :examiner, class_name: 'User'

  has_many :exams_diags
  has_many :diags, through: :exams_diags
  accepts_nested_attributes_for :exams_diags, allow_destroy: true, reject_if: :all_blank

  validates :weight, :height, :pulse, format: { with: /\A\d{1,3}(\.\d{1})?\z/ }, allow_blank: true
  validates :bp_systolic, :bp_diastolic, format: { with: /\A\d{1,3}\z/ }, allow_blank: true

  scope :customer_id_is, -> (cid) { where("customer_id = ?", cid)}

  #kaminari
  paginates_per 10
  
  class << self
    def ransackable_scopes(auth_object = nil)
      %i(customer_id_is)
    end
  end


  def bmi
    result = "N/A"
    if weight.present? && height.present?
      result = weight / ((height / 100) ** 2)
      result = result.round(2)
    end
    result
  end
  
end
