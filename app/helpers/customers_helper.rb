module CustomersHelper

  def prefix_select_form(f)
    f.select :prefix_id, options_for_select( \
      @prefixes.map{|p| [p.name, p.id, \
      { data: {"sex"=> p.sex } } ] }, \
      f.object.prefix_id \
    ), \
    {}, class: "selectpicker form-control", data: {"live-search" => true, "width" => "fit" }
  end

  def masked_id_card_no(customer)
    masked = customer.id_card_no
    if customer.id_card_no.present? && customer.id_card_no.length == Customer::ID_CARD_NO_LENGTH
      masked = insert_dash_at masked, 1
      masked = insert_dash_at masked, 6
      masked = insert_dash_at masked, 12
      masked = insert_dash_at masked, 15
    end
    masked
  end

  def masked_tel_no(customer)
    masked = customer.tel_no
    if customer.tel_no.present? && customer.tel_no.length == Customer::TEL_NO_LENGTH
      masked = insert_dash_at masked, 2
      masked = insert_dash_at masked, 7
    end
    masked
  end

  def masked_home_phone_no(customer)
    masked = customer.home_phone_no
    if customer.home_phone_no.present? && customer.home_phone_no.length == Customer::HOME_PHONE_NO_LENGTH
      masked = insert_dash_at masked, 1
      masked = insert_dash_at masked, 6
    end
    masked
  end

  private
    def insert_dash_at(str, pos)
      str.insert pos, Customer::DASH_SEPARATOR
    end

end
