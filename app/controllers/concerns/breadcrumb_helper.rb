module BreadcrumbHelper
  
  def bc(key, clazz)
    locale_key = nil
    case key
    when :list
      locale_key = "bc.list"
    when :show
      locale_key = "bc.show"
    when :new
      locale_key = "bc.new"
    when :edit
      locale_key = "bc.edit"
    end
    "#{I18n.t(locale_key)} #{clazz.model_name.human}"
  end

end