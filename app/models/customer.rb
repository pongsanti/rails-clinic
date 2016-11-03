class Customer < ActiveRecord::Base
  
  ID_PREFIX = "CS"

  ID_CARD_NO_LENGTH = 13
  TEL_NO_LENGTH = 10
  HOME_PHONE_NO_LENGTH = 9
  DASH_SEPARATOR = '-'

  acts_as_paranoid
  
  paginates_per 15

	belongs_to :prefix, inverse_of: :customers
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
    def include_prefix
      includes(:prefix)
    end

    # searchable fields
    def ransackable_attributes(auth_object = nil)
    #column_names + _ransackers.keys
      %w(id cn name surname id_card_no)
    end

    # `ransortable_attributes` by default returns the names
    # of all attributes available for sorting as an array of strings.
    def ransortable_attributes(auth_object = nil)
      %w(id cn name surname sex birthdate id_card_no created_at)
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

    def age(birthdate, current_date=DateTime.now.to_date)
      result = {year: 0, month: 0, day: 0}

      result[:year] = current_date.year - birthdate.year

      bd_day = (birthdate.leap? && birthdate.day == 29) ? 28 : birthdate.day
      #bd_day = birthdate.day
      bd_party_date_this_year = Date.new(current_date.year, birthdate.month, bd_day)
      
      last_bd_party = bd_party_date_this_year

      this_year_had_bd_party = (bd_party_date_this_year <= current_date)
      if not this_year_had_bd_party
        last_bd_party = Date.new(current_date.year - 1, birthdate.month, bd_day)
        result[:year] -= 1
      end

      day_count_from_last_bd_party = (current_date - last_bd_party).to_i
      result[:month] = day_count_from_last_bd_party / 30
      result[:day] = day_count_from_last_bd_party % 30

      return result
    end
    
  end

  def set_cn
    self.cn = Customer.latest_cn
  end

  private
    def delete_masked_input
      delete_dash_separator(:id_card_no)
      delete_dash_separator(:home_phone_no)
      delete_dash_separator(:tel_no)
    end

    def delete_dash_separator(attribute)
      current_value = self.send("#{attribute}")
      
      if current_value.present?
        self.send("#{attribute}=", current_value.delete(DASH_SEPARATOR))
      end

    end
end
