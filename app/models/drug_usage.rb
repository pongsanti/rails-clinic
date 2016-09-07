class DrugUsage < ActiveRecord::Base

  ID_PREFIX = "US"

  acts_as_paranoid

  paginates_per 10

  validates :code, presence: true
  validates :text, presence: true
  validates :times_per_day, :numericality => true, allow_blank: true
  validates :use_amount, :numericality => true, allow_blank: true

  def code_text
    "#{code} : #{text}"
  end

end
