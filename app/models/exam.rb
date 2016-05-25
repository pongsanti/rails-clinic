class Exam < ActiveRecord::Base

  belongs_to :customer
  belongs_to :examiner, class_name: 'User'

  validates :phase, presence: true
  validates :weight, :height, :pulse, format: { with: /\A\d{1,3}(\.\d{1})?\z/ }, allow_blank: true
  validates :bp_systolic, :bp_diastolic, format: { with: /\A\d{1,3}\z/ }, allow_blank: true

  scope :created_after, -> (time) { where("created_at > ?", time) }
  scope :customer_id_is, -> (cid) { where("customer_id = ?", cid)}
  scope :phase_is, -> (p) { where("phase = ?", p ) }

end
