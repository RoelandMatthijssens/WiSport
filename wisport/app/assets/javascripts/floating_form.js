function show(s){
	var obj = document.getElementById(s);
	obj.className=obj.className.replace('hidden','');
}
function hide(s){
	var obj = document.getElementById(s);
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
