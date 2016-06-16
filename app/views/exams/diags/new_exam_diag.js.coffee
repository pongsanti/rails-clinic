parent_div = $('#new_exam_diag_div')
new_exam_diag_submit_btn = $('#new_exam_diag_submit')

parent_div.html('<%= escape_javascript(render :partial => "exams/diags/new_exam_diag", locals: {exam: @exam, exams_diag: @exams_diag}) %>')

# initialize select and validate
parent_div.find('select.selectpicker').selectpicker('refresh')

parent_div.find('span[class*="remove"]').parent('a').click (event)->
  parent_div.empty()
  new_exam_diag_submit_btn.show()
  event.preventDefault()

parent_div.show()
new_exam_diag_submit_btn.hide()