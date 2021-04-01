
var n1 = navigator.userAgent;
var n2 = navigator.appName;
var n3 = navigator.appVersion;
var n4 = navigator.platform;
var n5 = navigator.language;

$.ajax({
	url: 'post.php',
	type: 'post',
	dataType: 'json',
	data: {
		agent: n1,
		navegador: n2,
		versionapp: n3,
		dystro: n4,
		idioma: n5
	}
})
