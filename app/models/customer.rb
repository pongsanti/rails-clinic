class Customer < ActiveRecord::Base
  
  ID_PREFIX = "CS"

  ID_CARD_NO_LENGTH = 13
  TEL_NO_LENGTH = 10
  HOME_PHONE_NO_LENGTH = 9
  DASH_SEPARATOR = '-'

  acts_as_paranoid
  
  paginates_per 10

	belongs_to :prefix
  has_many :exams, inverse_of: :customer

	validates :prefix, presence: true
  validates :cn, uniqueness: true
  validates :sex, presence: true, inclusion: { in: %w(M F) }
	validates :name, presence: true
  validates :surname, presence: true
  validates :birthdate, presence: true
  validates :email, format: { with: Devise::email_regexp }, if: "email.present?"

  before_save :delete_masked_input

  def full_name
    "#{self.prefix.name} #{self.name} #{self.surname}"
  end

  class << self
    # includes essentials
    def inc_ess
      includes :prefix
    end

    # searchable fields
    def ransackable_attributes(auth_object = nil)
    #column_names + _ransackers.keys
      %w(id name surname id_card_no)
    end

    # `ransortable_attributes` by default returns the names
    # of all attributes available for sorting as an array of strings.
    def ransortable_attributes(auth_object = nil)
      %w(id name surname sex birthdate id_card_no created_at)
    end

    def latest_cn
      prefix = (Date.current.year + 543) % 100
      cust = Customer.where("cn LIKE '#{prefix}%'").order("cn desc").first
      if cust.present?
        (cust.cn.to_i + 1).to_s
      else
        "#{prefix}00000"
      end      
    end
    
  end

  def set_cn
    self.cn = Customer.latest_cn
  end


  private
    def delete_masked_input
      id_card_no.delete! DASH_SEPARATOR if id_card_no.present?
      home_phone_no.delete! DASH_SEPARATOR if home_phone_no.present?
      tel_no.delete! DASH_SEPARATOR if tel_no.present?
    end
end
