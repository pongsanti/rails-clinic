class Customer < ActiveRecord::Base

	belongs_to :prefix

	validates :prefix, presence: true
  validates :sex, presence: true
	validates :name, presence: true
  validates :surname, presence: true
  validates :birthdate, presence: true

  def age_in_days
    age_in_days = nil

    unless self.birthdate.nil?
      age_in_days = (Time.now.to_date - self.birthdate).to_i
    end 
    age_in_days
  end

end
