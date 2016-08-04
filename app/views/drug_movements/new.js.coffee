parent_div = $("*[data-placefor='<%= @holder%>']")
html_form = '<%= j(render :partial => "new", locals: {drugs: @drugs, exam_id: @exam_id}) %>'
parent_div.html html_form

# initialize select tag
gInitSelectPicker parent_div.find("form")

#close button
$("a[data-remove='<%= @holder%>']").click ()->
  parent_div.fadeOut "fast", ()->
    parent_div.empty().show()