#reload list
list_parent_div = $("*[data-list-holder='<%= @list_holder%>']")
html_list = '<%= j(render :partial => "exams/drugs/drugs", locals: {exam: @exam}) %>'
list_parent_div.html html_list