module ExamsHelper
  def select_drug_in
    select_tag "drug_ins", options_for_select( \
        @drug_ins.map{ |d| [select_drug_in_text(d), d.id, \
        { data: {"subtext"=> select_drug_in_subtext(d), "sale" => d.sale_price_per_unit } } ] } \
      ), \
      class: "form-control", data: { 'live-search' => true }
  end

  def select_drug_in_form(f)
    f.select :drug_in_id, options_for_select( \
      @drug_ins.map{ |d| [select_drug_in_text(d), d.id, \
      { data: {"subtext" => select_drug_in_subtext(d), "sale" => d.sale_price_per_unit } } ] }, \
      f.object.drug_in_id \
    ), \
    {}, class: "selectpicker form-control", data: {"live-search" => true }
  end

  def select_drug_usage
    select_tag "drug_usages", options_for_select( \
      @drug_usages.map{ |d| [d.code, d.id, \
      { data: {"subtext"=> d.text } } ] } \
    ), \
    class: "form-control", data: { 'live-search' => true }
  end

  def select_drug_usage_form(f)
    f.select :drug_usage_id, options_for_select( \
      @drug_usages.map{|d| [d.code, d.id, \
      { data: {"subtext"=> d.text } } ] }, \
      f.object.drug_usage_id \
    ), \
    {}, class: "selectpicker form-control", data: {"live-search" => true }
  end

  private
    def select_drug_in_text(drug_in)
      "#{drug_in.drug.name} (Exp: #{drug_in.expired_date})"
    end

    def select_drug_in_subtext(drug_in)
      "Bal. #{drug_in.balance}"
    end
end
