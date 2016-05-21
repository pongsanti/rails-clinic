class Customer < ActiveRecord::Base
  
  ID_CARD_NO_LENGTH = 13
  TEL_NO_LENGTH = 10
  HOME_PHONE_NO_LENGTH = 9
  DASH_SEPARATOR = '-'
  
  paginates_per 20

	belongs_to :prefix
  has_many :exams

	validates :prefix, presence: true
  validates :sex, presence: true, inclusion: { in: %w(M F) }
	validates :name, presence: true
  validates :surname, presence: true
  validates :birthdate, presence: true
  validates :email, format: { with: Devise::email_regexp }, if: "email.present?"

  before_save :delete_masked_input

  private
    def delete_masked_input
      id_card_no.delete! DASH_SEPARATOR if id_card_no.present?
      home_phone_no.delete! DASH_SEPARATOR if home_phone_no.present?
      tel_no.delete! DASH_SEPARATOR if tel_no.present?
    end

end
