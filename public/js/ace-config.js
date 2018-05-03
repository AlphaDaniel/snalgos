var editor = ace.edit("editor");
ace.require('ace/ext/settings_menu').init(editor);

////////////////////////////////////////////////////////////////////////////////////////////////////
//  SETTINGS                                                                                      //
////////////////////////////////////////////////////////////////////////////////////////////////////

// editor theme
editor.setTheme("ace/theme/cobalt");

//font size
document.getElementById('editor').style.fontSize='20px';

//tab size
editor.getSession().setTabSize(2);

//print margin visibility
editor.setShowPrintMargin(false); 

// default wrap
editor.session.setUseWrapMode(true);

////////////////////////////////////////////////////////////////////////////////////////////////////
//  SETTINGS MENU                                                                                 //
////////////////////////////////////////////////////////////////////////////////////////////////////

// settings menu keybinding
editor.commands.addCommands([{
	name: "showSettingsMenu",
	bindKey: {win: "Ctrl-i", mac: "Command-i"},
	exec: function(editor) {
		editor.showSettingsMenu();
	},
	readOnly: true
}]);

// Open Menu
$('.ace-settings').click(function() {
	ace.edit("editor").showSettingsMenu();
});

////////////////////////////////////////////////////////////////////////////////////////////////////

$(document).ready(function() {
	$('.mode').text(editor.session.getMode().$id.replace(/ace\/mode\//g, "").toUpperCase());
});

editor.session.on("changeMode", function() {
	$('.mode').text(editor.session.getMode().$id.replace(/ace\/mode\//g, "").toUpperCase());
}); 


//get/set
var textarea = $('input[name="content"]');

editor.getSession().on("change", function () {
    textarea.val(editor.getSession().getDocument().getAllLines().join("xNLx"));
    
    $(".ace_scrollbar.ace_scrollbar-v").getNiceScroll().resize();
});


$(document).click(function() {
	$('input[name="mode"]').val(editor.session.getMode().$id);
});