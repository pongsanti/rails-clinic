parent_div = $("#edit_exam_diag_div")

parent_div.html '<%= escape_javascript(render :partial => "edit_exam_diag", locals: {exam: @exams_diag.exam, exams_diag: @exams_diag}) %>'

# initialize select and validate
parent_div.find('select.selectpicker').selectpicker('refresh')

# close button
parent_div.find('span[class*="remove"]').parent('a').click (event)->
  parent_div.empty()
  event.preventDefault()

parent_div.show()