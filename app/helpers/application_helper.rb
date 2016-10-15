module ApplicationHelper
  
  def id(string)
    "\##{string}"
  end

  def th_date_format(d)
    unless d.blank?
      thai_year = d.strftime("%Y").to_i + 543
      l(d, format: "%d %b ") + thai_year.to_s
    end
  end

  def th_date_time_format(d)
    unless d.blank?
      th_date_format(d) + l(d, format: " %H:%M")
    end
  end

  def th_time_format(t)
    unless t.blank?
      l(t, format: "%H:%M")
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

  def currency num
    if num == nil || num.blank?
      num = 0.0
    end

    number_to_currency num, unit: "$"
  end

  def decimal num
    if num == nil || num.blank?
      num = 0.0
    end

    number_to_currency num, unit: ""
  end

  def toggleTarget(id)
    "#{id}Body"
  end

  def panel_header_layout
    "global/panel/layout/header"
  end

  def panel_footer
    "global/panel/footer"
  end

  def panel_new_btn
    "global/panel/new_btn"
  end

  def panel_edit_btn
    "global/panel/edit_btn"
  end

  def home_title_text
    if current_user.client.name.present?
      current_user.client.name
    else
      "Dashboard"
    end
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
