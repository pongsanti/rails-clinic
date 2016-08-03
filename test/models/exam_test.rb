require 'test_helper'
require 'models/common'

class ExamTest < ActiveSupport::TestCase
  include Common

  def setup
    @exam = exams(:exam_one)
  end

  test "should not validate weight if empty" do
    @exam.weight = nil
    assert @exam.save
    error_count 0
  end

  test "should validate weight if present" do
    weight = "activerecord.attributes.exam.weight"

    @exam.weight = 1000
    assert_not @exam.save
    error_count 1
    error_contains error_msg(weight, ERR_INVALID)
  end

  private
    def error_count(count)
      assert_equal count, @exam.errors.count
    end

    def error_contains(*msgs)
      found = 0
      msgs.each do |msg|
        found = found + 1 if @exam.errors.full_messages.include? msg
      end
      assert_equal msgs.count, found
    end

    def t(key)
      I18n.t key
    end

    def error_msg(attr_key, error_key)
      "#{t(attr_key)} #{t(error_key)}"
    end

end