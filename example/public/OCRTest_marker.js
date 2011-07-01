var startX;
var startY;
var endX;
var endY;

var ocr_image_left;
var ocr_image_top;


function draw_rectangle() {
	var top;
	var left;
	var height;
	var width;
	
	// Linker Abstand und Seitenlänge
	if (startX < endX) {
		left = startX;
		width = endX - startX;
	}
	else {
		left = endX;
		width = startX - endX;
	}
	
	// Abstand oben und Seitenlänge
	if(startY < endY) {
		top = startY;
		height = endY - startY;
	}
	else {
		top = endY;
		height = startY - endY;
	}
	
	// Muss draufgerechnet werden, damit Position relativ zum Elternelement
	top += ocr_image_top;
	left += ocr_image_left;
	
	var div = $("<span></span>").addClass('marked').css('top',top).css('left',left).height(height).width(width);
	div.append(startX + " "+ startY + " "+ endX +" " + endY);
	$("#ocr_image").append(div);
	
	get_marked_words();
}


function get_marked_words() {
	var x1;
	var y1;
	var x2;
	var y2;
	
	if (startX < endX) {
		x1 = startX;
		x2 = endX;
	}
	else {
		x1 = endX;
		x2 = startX
	}
	
	if (startY < endY) {
		y1 = startY;
		y2 = endY ;
	}
	else {
		y1 = endY;
		y2t = startY;
	}
	
	$.ajax({
		url:	'http://localhost:4567/mark',
		data:	'x1=' + x1 + '&y1=' + y1 + '&x2='+ x2 + '&y2=' + y2 + '&page=Seite_Tagebuch_H_C_Lang_08.html',
		success:	add_marked_words
	})
}

function add_marked_words(data) {
	var span = $("<div></div>").addClass('selected_words').append(data);
	$("#marked_words").append( span );
	
}
