$(function(){
	$("body").append("<h1>JS WORKING</h1>");
	$("body").append(navigator.userAgent);

	var userAgent = navigator.userAgent

	if (userAgent.match(/PhantomJS/g)) {
		$("body").append("<h1>PHANTOM</h1>");
		$("body").addClass('print');
	}


});