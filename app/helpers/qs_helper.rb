module QsHelper

  def tr_class(q)
    if q.active
      case q.category
      when Q::EXAM_Q_CAT
        "info"
      when Q::MED_Q_CAT
        "success"
      else
        ""
      end
    end
  end
end