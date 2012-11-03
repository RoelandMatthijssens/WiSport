function hide_popups(){
	delay_hide('.popup', 0);
	delay_hide('.floating_form', 0);}
function delay_hide(queryStr, time) { $(function() {
    setTimeout(function() {
		        $(queryStr).hide('fast')
						    }, time);
								});}
$(document).keyup(function(e) {
	if (e.keyCode == 27) { hide_popups() }   // esc
		});
			
function show(s){
	var obj = document.getElementById(s);
	obj.style.display='block';
	obj.className=obj.className.replace('hidden','');
}
function hide(s){
	var obj = document.getElementById(s);
	obj.style.display='none';
	obj.className+='hidden'
}
function show_overlay(){
	show('overlay');
}
function hide_overlay(){
	hide('overlay');
}
function open_floating_form(s){
	var obj = document.getElementById(s);
	show_overlay();
	show(obj.id);
}
function close_floating_form(s){
	var obj = document.getElementById(s);
	hide_overlay();
	hide(obj.id);
}
