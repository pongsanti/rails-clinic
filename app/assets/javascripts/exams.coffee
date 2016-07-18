# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

drug_drug_ins_path_pattern = (drug_id)->
  "/drugs/#{drug_id}/drug_ins"

initializePage = ->
  # new exam button click ajax error
  $('a[href*="new_patient_diag"]').on 'ajax:error', (event, xhr, status, error)-> gShowErrorModal error

  # append anchor to form action url
  $('form').each (index, form) ->
    f = $(form)
    anchor = f.data('anchor')
    if anchor?
      action = f.attr 'action'
      f.attr 'action', "#{action}#" + anchor

  # drug id
  $('select#drug_in_drug_id').on "change", ()->
    $('a#link_drug_drug_ins_path').attr("href", drug_drug_ins_path_pattern(this.value) )

$(document).on('turbolinks:load', initializePage)

