function checkKeyPressed(keyEvent) {
	var theSelection = getSelectedText() + "";
	if (theSelection.length > 0) {
	  keyEvent = (keyEvent) ? keyEvent : (window.event) ? event : null;
	  if (keyEvent) {
		var charCode = (keyEvent.charCode) ? keyEvent.charCode :
					   ((keyEvent.keyCode) ? keyEvent.keyCode :
					   ((keyEvent.which) ? keyEvent.which : 0));
		var theword = encodeURIComponent(theSelection);
		if (charCode == 100) createDictWindow(dictURL + theword);
	  }
	}
}

function createDictWindow(url) {
    var windowName = "dicwin";
    var features = "width=560,height=600,directories=0,location=1,menubar=1,scrollbars=1,status=1,toolbar=1,resizable=1";
	var dicwin =  window.open (url, windowName, features);
	if (dicwin) dicwin.focus();
}

function getSelectedText() {
	var selectText = (window.getSelection) ? window.getSelection() : 
					(document.getSelection) ? document.getSelection() :
					(document.selection) ? document.selection.createRange().text : null;
	return selectText;
}
