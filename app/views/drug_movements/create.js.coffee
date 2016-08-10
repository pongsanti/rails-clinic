#reload list
list_parent_div = $("*[data-list-holder='<%= @list_holder%>']")
html_list = '<%= j(render :partial => "exams/drugs/drugs", locals: {exam: @exam}) %>'
list_parent_div.html html_list
#reload form
$.get('<%= new_drug_movement_url(holder: @holder, list_holder: @list_holder, "drug_movement[exam_id]" => @exam.id) %>')