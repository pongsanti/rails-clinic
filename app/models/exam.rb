class Exam < ActiveRecord::Base

  belongs_to :customer
  belongs_to :examiner, class_name: 'User'
end
