@expand_trainings_session = (id) ->
  	$(".trainings_session_" + id).toggle()

$ ->
	$("#trainingsessions_pagination .pagination a").live "click", ->
		$.getScript @href
		false
	serialize_form = () ->
		$("#trainings_sessions_search").serialize()+"&"+$("#title_search").serialize()+"&"+$("#owner_search").serialize()+"&"+$("#description_search").serialize()
	submit_trainings_sessions_search = () ->
		$.get $("#trainings_sessions_search").attr("action"), serialize_form(), null, "script"
		false
	$("#title_search").keyup ->
		submit_trainings_sessions_search()
	$("#owner_search").keyup ->
		submit_trainings_sessions_search()
	$("#description_search").keyup ->
		submit_trainings_sessions_search()
