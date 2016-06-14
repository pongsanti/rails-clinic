parent_div = $("#edit_exam_diag_div")

parent_div.html '<%= escape_javascript(render :partial => "edit_exam_diag", locals: {exam: @exams_diag.exam, exams_diag: @exams_diag}) %>'

# initialize select and validate
parent_div.find('select.selectpicker').selectpicker('refresh')

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