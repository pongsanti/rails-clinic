module Util
  class AgeText
    
    attr_accessor :age_in_days

    def initialize(age_in_days = nil)
      @age_in_days = age_in_days
    end

    def year
      unless age_in_days.nil?
        age_in_days / 365
      end
    end

    def month
      unless age_in_days.nil?
        (age_in_days % 365) / 30
      end
    end

    def day
      unless age_in_days.nil?
        (age_in_days % 365) % 30
      end
    end

  end
end