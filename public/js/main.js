////////////////////////////////////////////////////////////////////////////////////////////////////
//  DOCUMENT READY                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////

$(document).ready(function() {
	// ACTIVATE NICESCROLL
	$(function() {  
	    $("#tags-list").niceScroll({cursorborder: "none", autohidemode: true});
	    $(".snippets").niceScroll({cursorborder: "none", autohidemode: true});
	    $(".ace_scrollbar.ace_scrollbar-v").niceScroll({cursorborder: "none", autohidemode: true});
	});
	
    // SET ACTIVE LINK
    $("[href$='dashboard']").removeClass("active");
    var status = "none";
    $("[href]").each(function() {
        if (this.href == window.location.href) {
            $(this).addClass("active");
            status = "found";
        }
    });
    if (status === "none") { $("[href$='dashboard']").addClass("active"); }
    
    // FLASH MESSAGES
	$('.confirmation').slideToggle(300);
	$('.alert').slideToggle(300);
	setTimeout(function(){ $('.confirmation').fadeOut(200); }, 2000);
	setTimeout(function(){ $('.alert').fadeOut(200); }, 8000);
	
	// SCROLLREVEALS
	window.sr = ScrollReveal();
	sr.reveal('.snippet', { container: '.snippets', duration: 1000 });
	// sr.reveal('.tag', { container: '#tags-list', duration: 1000});
});

////////////////////////////////////////////////////////////////////////////////////////////////////
//  ON WINDOW RESIZE                                                                              //
////////////////////////////////////////////////////////////////////////////////////////////////////

$( window ).resize(function() {
	hidemobilemenu();
	$("#menuToggle").removeClass( "active" );
	if ($(window).width() > 650) { $(".menuItem").show(); }
	if ($(window).width() <= 750) { $(".tw-dash").css({display: "none"}); }
	if ($(window).width() > 750) { $(".tw-dash").css({display: "grid"}); }
});

////////////////////////////////////////////////////////////////////////////////////////////////////
//  ON DOCUMENT CLICK                                                                             //
////////////////////////////////////////////////////////////////////////////////////////////////////

$(document).click(function() {
// CLICK AWAY TO CLOSE
var list = $(".message");
	
	list.fadeOut(200);
    
	if ($(".menuItem").hasClass("moved")) { 
		hidemobilemenu(); 
		$("#menuToggle").toggleClass( "active" );
	}
	
});
// DONT CLOSE IF CLICKED
var ignore = $("#menuToggle, .tag-toggle");
ignore.click(function(e) { e.stopPropagation(); return false; });


////////////////////////////////////////////////////////////////////////////////////////////////////
//  MENU                                                                                          //
////////////////////////////////////////////////////////////////////////////////////////////////////

// MOBILE MENU
function showmobilemenu(){
	$("#mobileMenu").css("display", "grid");
	$(".menuItem").appendTo($("#mobileMenu"));
	$(".menuItem").show().addClass("moved");
}
function hidemobilemenu(){
	$(".menuItem").removeClass("moved");    
	$(".menuItem").appendTo($("header"));
	$(".menuItem").hide() && $("#mobileMenu").hide();
}
$("#menuToggle").click(function() {
	if (!$(".menuItem").hasClass("moved")) { 
		showmobilemenu(); 
	} else { 
		hidemobilemenu(); 
	}
});

// ANIMATED HAMBURGER ICON
$("#menuToggle").click(function() { this.classList.toggle( "active" ); });


////////////////////////////////////////////////////////////////////////////////////////////////////
//  TAG SLIDEOUT                                                                                  //
////////////////////////////////////////////////////////////////////////////////////////////////////

// TAGS GENERAL
$(".tag-toggle, .close-tags").click(function(){
	
	$(".tags-slide").animate({ width: "toggle"}, "fast");
	// sr.reveal('.tag', { container: '#tags-list', duration: 1000});
	
	setTimeout(function(){ 
		// $("#tags-list").trigger("click");
		
		$("#tags-list").animate({scrollTop:100,});
		$("#tags-list").delay(50).animate({scrollTop:0,});
		
		$("#tags-list").getNiceScroll().resize();
	}, 200);
});

// DASH TAGS
if ($(window).width() <= 750) { $(".tw-dash").css({display: "none"})}

$(".tt-dash, .close-tags").click(function(){
	// $("#tags-list").getNiceScroll().resize();
	$(".tw-dash").animate({ width: "toggle"}, "fast");
	// sr.reveal('.tag', { container: '#tags-list', duration: 1000});
});

// NEW TAG TOGGLE
$("#new-tag-toggle").click(function(){
	$("#new-tag").animate({ height: "toggle"}, 300);
});

////////////////////////////////////////////////////////////////////////////////////////////////////
//  OTHER                                                                                         //
////////////////////////////////////////////////////////////////////////////////////////////////////

// FOOTER COPYWRITE YEAR
$( "#year" ).append( new Date().getFullYear() );

////////////////////////////////////////////////////////////////////////////////////////////////////




/////////////////////////////////////////////////////////////////////
// ISSUE - CLICK AWAY FOR TAGS SLIDE OUT//  
//
// when label clicked tags animate in and out when I try to
// stop progation on label or checkbox checkbox will not toggle to 
// checked (code in question immediately below)
//-----------------------------------------------------------------//
// if($(".tags-slide").is(':visible')){
// 	$(".tags-slide").animate({ width: "toggle"}, "fast");
// }	
/////////////////////////////////////////////////////////////////////