class ExamPolicy < ApplicationPolicy
  
  #show
  def show_pe?
    doctor_or_higher?
  end

  def show_diag?
    doctor_or_higher?
  end

  def show_drug?
    doctor_or_higher?
  end

  def show_revenue?
    doctor_or_higher?
  end


  #edit
  def edit_pe?
    doctor_or_higher?
  end

  def edit_appointment?
    doctor_or_higher?
  end


  #update
  def update_pe?

  end
  
  def update_appointment?
    doctor_or_higher?
  end

end