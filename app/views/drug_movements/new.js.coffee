parent_div = $("*[data-holder='<%= @holder%>']")
html_form = '<%= j(render :partial => "new", locals: {drugs: @drugs, exam_id: @exam_id}) %>'

parent_div.hide()
parent_div.html html_form
parent_div.fadeIn "fast", ()->
    parent_div.show()

# initialize select tag
gInitSelectPicker parent_div.find("form")

#close button
$("a[data-remove='<%= @holder%>']").click ()->
  parent_div.fadeOut "fast", ()->
    parent_div.empty()