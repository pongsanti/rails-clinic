parent_div = $("*[data-placefor='index_select']")
parent_div.html "<%= j(render "drug_ins/index_select", drug_ins: @drug_ins) %>"
gInitSelectPicker parent_div