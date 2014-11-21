// Turn the note on (visible)
// and load it


function displayNote(refobject, theURL) {

	theID = "note_" + refobject;

       if ($(theID).style.display == "block") {
	   $(theID).style.display = "none";
       } else {
		theID = "note_" + refobject;
		if ($(theID).innerHTML == "") {
			$(theID).innerHTML = "Loading note...";		
			new ajax (theURL, {update: $(theID)});
		}
		$(theID).style.display = "block";
	}
}

// Kill it...

function hideNote(refobject) {
   $("note_" + refobject).style.display = "none";
}
