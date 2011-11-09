$(function() {
	$("#menu li").each(function(index) {
							   $(this).click(function() {
													  $("#menu li.tabFocus").removeClass("tabFocus");
													  $(this).addClass("tabFocus");
													  $("#content li:eq(" + index + ")").show().siblings().hide();
													  });
							   });
})