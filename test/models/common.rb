module Common

  ERR_PREFIX = "errors.messages."
  ERR_BLANK = ERR_PREFIX + "blank"
  ERR_INCLUSION = ERR_PREFIX + "inclusion"
  ERR_INVALID = ERR_PREFIX + "invalid"
   
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

  def t(key)
    I18n.t key
  end

  def error_msg(attr_key, error_key)
    "#{t(attr_key)} #{t(error_key)}"
  end

  def should_not_validate_if_empty(attr)
    @test_target[attr] = nil
    assert @test_target.save
    error_count 0
  end
  
end