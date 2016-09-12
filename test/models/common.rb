module Common

  ERR_PREFIX = "errors.messages."
  ERR_BLANK = ERR_PREFIX + "blank"
  ERR_INCLUSION = ERR_PREFIX + "inclusion"
  ERR_INVALID = ERR_PREFIX + "invalid"
  ERR_NOT_A_NUMBER = ERR_PREFIX + "not_a_number"
  ERR_GTEQ = ERR_PREFIX + "greater_than_or_equal_to"
  ERR_LESS_THAN = ERR_PREFIX + "less_than"
  ERR_LESS_THAN_OR_EQUAL_TO = ERR_PREFIX + "less_than_or_equal_to"
   
  def error_count(count)
    assert_equal count, @test_target.errors.count
  end

  def error_contains(*msgs)
    found = 0
    msgs.each do |msg|
      found = found + 1 if @test_target.errors.full_messages.include? msg
    end
    assert_equal msgs.count, found
  end

  def t(key, t_var={})
    I18n.t key, t_var
  end

  def error_msg(attr_key, error_key, t_var={})
    "#{t(attr_key)} #{t(error_key, t_var)}"
  end

  def should_not_validate_if_empty(attr)
    @test_target[attr] = nil
    assert @test_target.save
    error_count 0
  end
  
end