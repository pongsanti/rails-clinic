parent_div = $("#drug_drug_ins_select_div")
parent_div.html "<%= j(render "drug_ins/drug_drug_ins_select", drug_ins: @drug_ins) %>"
gInitSelectPicker parent_div