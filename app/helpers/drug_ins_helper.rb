module DrugInsHelper
  def drugin_id id
    "LT" + ("%05d" % id)
  end
end