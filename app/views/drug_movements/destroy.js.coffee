#reload list
list_parent_div = $("*[data-list-holder='<%= @list_holder%>']")
html_list = '<%= j(render :partial => "exams/drugs/drugs", locals: {exam: @exam}) %>'
list_parent_div.html html_list
#close form if present
parent_div = $("*[data-holder='<%= @holder%>']")
if parent_div
  parent_div.fadeOut "fast", ()->
    parent_div.empty().show()