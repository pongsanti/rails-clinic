parent_div = $('#new_exam_diag_div')
new_exam_diag_submit_btn = $('#new_exam_diag_submit')

parent_div.html('<%= escape_javascript(render :partial => "exams/diags/new_exam_diag", locals: {exam: @exam, exams_diag: @exams_diag}) %>')

form = parent_div.find 'form'
# initialize select tag
gInitSelectPicker form

# init form validation
gInitFormValidation form

# form submit error event
form.on 'ajax:error', (event, xhr, status, error)->
  gShowErrorModal error

# close button event
parent_div.find('span[class*="remove"]').parent('a').click (event)->
  parent_div.empty()
  new_exam_diag_submit_btn.show()
  event.preventDefault()

parent_div.show()
new_exam_diag_submit_btn.hide()