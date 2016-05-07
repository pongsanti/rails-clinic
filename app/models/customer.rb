class Customer < ActiveRecord::Base

  paginates_per 20

	belongs_to :prefix
  has_many :exams

	validates :prefix, presence: true
  validates :sex, presence: true
	validates :name, presence: true
  validates :surname, presence: true
  validates :birthdate, presence: true

end
