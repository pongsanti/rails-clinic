$('#new_exam_diag_div').append('<%= escape_javascript(render :partial => "new_exam_diag", locals: {exam: @exam, exams_diag: @exams_diag}) %>')
$('#new_exam_diag_div').show()
$('#new_exam_diag_submit').hide()