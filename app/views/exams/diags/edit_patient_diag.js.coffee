parent_div = $("#edit_patient_diag_div")

parent_div.html '<%= escape_javascript(render :partial => "exams/diags/edit_patient_diag", locals: {exam: @patient_diag.exam, patient_diag: @patient_diag}) %>'

form = parent_div.find 'form'

# initialize select tag
gInitSelectPicker(form)

# init form validation
gInitFormValidation form

# confirm if destroy is checked
parent_div.find('input[type="checkbox"]').click ()->
  submit_btn = parent_div.find 'input[type="submit"]'
  if $(this).is ':checked'
    submit_btn.data "confirm", "Are you sure you want to delete?"
  else
    submit_btn.data "confirm", null

# clear div after update success
parent_div.find('form').on 'ajax:success', (event, xhr, status)->
  parent_div.empty()
    
# close button
parent_div.find('span[class*="remove"]').parent('a').click (event)->
  parent_div.empty()
  event.preventDefault()

parent_div.show()