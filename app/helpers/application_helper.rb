module ApplicationHelper
  
<<-DOC

  # this function will be removed.

  def th_year(customer)
    unless customer.birthdate.nil?
      customer.birthdate.year + 543
    end
  end
DOC

  def th_date_format(d)
    unless d.blank?
      thai_year = d.strftime("%Y").to_i + 543
      l(d, format: "%d %b ") + thai_year.to_s
    end
  end

  def th_date_time_format(d)
    unless d.blank?
      th_date_format(d) + l(d, format: " %T")
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
  
  def format_id obj
    id_prefix(obj.class) + ("%05d" % obj.id)
  end

  private
    def id_prefix claz
      claz.const_get(:ID_PREFIX) || ""
    end

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
