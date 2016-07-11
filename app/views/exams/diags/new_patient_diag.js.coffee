parent_div = $('#new_patient_diag_div')
new_patient_diag_submit_btn = $('#new_patient_diag_submit')

parent_div.html('<%= escape_javascript(render :partial => "exams/diags/new_patient_diag", locals: {exam: @exam, patient_diag: @patient_diag}) %>')

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
  parent_div.fadeOut "fast", ()->
    parent_div.empty()
  new_patient_diag_submit_btn.fadeIn()
  event.preventDefault()

parent_div.fadeIn()
new_patient_diag_submit_btn.hide()