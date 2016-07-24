parent_div = $("#new_exam_drug")
html_form = '<%= escape_javascript(render :partial => "exams/drugs/new_exam_drug", locals: {drugs: @drugs}) %>'
parent_div.html html_form

# initialize select tag
gInitSelectPicker parent_div.find("form")