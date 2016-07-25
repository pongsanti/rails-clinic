module DrugInsHelper
  def format_id id
    "LT" + ("%05d" % id)
  end
end
