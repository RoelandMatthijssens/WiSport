# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).on 'click', '.remove_fields', (event) ->
  $(this).prev().find("input[type=hidden]").val('1')
  $(this).closest('div').hide()
  event.preventDefault()


$(document).on 'click', '.add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).before($(this).data('fields').replace(regexp, time))
  event.preventDefault()

$(document).on 'change', '#exercise_type', (event) ->
	$("#time_exercise").removeClass "hidden"
	$("#distance_exercise").removeClass "hidden"
	$("#reps_exercise").removeClass "hidden"



