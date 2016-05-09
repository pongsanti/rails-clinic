module ApplicationHelper
  
  def th_year(customer)
    unless customer.birthdate.nil?
      customer.birthdate.year + 543
    end  
  end

  def age_text(customer)
    unless customer.birthdate.nil?
      age_in_days = (Time.now.to_date - customer.birthdate).to_i
      s = StringIO.new
      s << year(age_in_days).to_s << " " << I18n.t('customers.show.years') << " "
      s << month(age_in_days).to_s << " " << I18n.t('customers.show.months') << " "
      s << day(age_in_days).to_s << " " << I18n.t('customers.show.days')
      s.string
    end
  end

  private
    def year(age_in_days)
      age_in_days / 365
    end

    def month(age_in_days)
      (age_in_days % 365) / 30
    end

    def day(age_in_days)
      (age_in_days % 365) % 30
    end
     
end
