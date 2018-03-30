var editor = ace.edit("editor");
// SETTINGS MENU
ace.require('ace/ext/settings_menu').init(editor);
// SETTINGS MENU KEYBINDING
editor.commands.addCommands([{
	name: "showSettingsMenu",
	bindKey: {win: "Ctrl-q", mac: "Ctrl-q"},
	exec: function(editor) {
		editor.showSettingsMenu();
	},
	readOnly: true
}]);
// DEFAULT LANGUAGE
editor.session.setMode("ace/mode/ruby");
// EDITOR THEME
editor.setTheme("ace/theme/cobalt");
//FONT SIZE
document.getElementById('editor').style.fontSize='1.5em';
//TAB SIZE
editor.getSession().setTabSize(2);
//PRINT MARGIN VISIBILITY
editor.setShowPrintMargin(false); 
//CAPTURE/SET VALUE
var textarea = $('input[name="content"]');
editor.getSession().on("change", function () {
		// textarea.val(editor.getSession().getValue());
    // textarea.val(editor.getSession().getValue().split("\n").join("\n"));
    textarea.val(editor.getSession().getDocument().getAllLines());
});



