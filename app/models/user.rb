class User < ActiveRecord::Base

  ID_PREFIX = "U"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :exams, foreign_key: 'examiner_id'
  belongs_to :client
  belongs_to :user
end
