module BreadcrumbHelper
  
  def bc(key, clazz)
    locale_key = "bc.#{key}"
    case key
    when :list
      "#{clazz.model_name.human} #{I18n.t(locale_key)}"
    when :show
      "#{clazz.model_name.human}"
    else
      "#{I18n.t(locale_key)} #{clazz.model_name.human}"
    end
  end

end