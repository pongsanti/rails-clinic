class DrugUsage < ActiveRecord::Base

  def code_text
    "#{code} : #{text}"
  end

end
