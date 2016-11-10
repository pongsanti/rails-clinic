ActionView::Helpers::DateTimeSelector.class_eval do
  def build_options_and_select(type, selected, options = {})
    if type == :year
      build_select(type, build_year_options(selected, options))
    else
      build_select(type, build_options(selected, options))
    end
  end  

  # add option for buddhist era to be displayed
  def build_year_options(selected, options = {})
    options = {
      leading_zeros: true, ampm: false, use_two_digit_numbers: false
    }.merge!(options)


    start         = options.delete(:start) || 0
    stop          = options.delete(:end) || 59
    step          = options.delete(:step) || 1
    leading_zeros = options.delete(:leading_zeros)

    select_options = []
    start.step(stop, step) do |i|
      value = leading_zeros ? sprintf("%02d", i) : i
      tag_options = { :value => value }
      tag_options[:selected] = "selected" if selected == i
      
      text = options[:use_two_digit_numbers] ? sprintf("%02d", i) : value
      text = options[:ampm] ? AMPM_TRANSLATION[i] : text

      text = @options[:buddhist_era] ? "#{text} (#{text + 543})" : text

      select_options << content_tag(:option, text, tag_options)
    end

    (select_options.join("\n") + "\n").html_safe
  end

end