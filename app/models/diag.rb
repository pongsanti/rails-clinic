class Diag < ActiveRecord::Base 

  ID_PREFIX = "DI"

  acts_as_paranoid
  
  paginates_per 10

  has_many :patient_diags
  has_many :exams, through: :patient_diags

  validates :name, presence: true

  class << self
    # searchable fields
    def ransackable_attributes(auth_object = nil)
    #column_names + _ransackers.keys
      %w(id name description)
    end
  end
  
end