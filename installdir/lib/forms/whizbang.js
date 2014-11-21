var allids = new Array();

var activeid = "none";


if (document.getElementById && document.getElementsByTagName && document.createTextNode) {
	document.write('<link rel="stylesheet" type="text/css" href="whizbang.css" />');
	window.onload = initialize;
}


function initialize() {
	
	var id;
	var navbar = document.getElementById('nav');
	var navlinks = navbar.getElementsByTagName('a');

	for (var j = 0; j < navlinks.length; j++) {
		allids[j] = navlinks[j].href.match(/#(\w.+)/)[1];
		navlinks[j].href = "#";
		navlinks[j].onclick = new Function("sshow('" + allids[j] + "');");
	}
	
	addLabelProperties();

	document.getElementById("query").innerHTML = '<h2>Your query:</h2><div id="querytext">Enter search criteria to form a new search.</div>';
	document.getElementById("resetbutton").onclick = new Function ("document.forms[0].reset(); hideall(); setActiveTab('none'); formulateQuery();"); 

	hasquery = formulateQuery();

	if (window.location.href.indexOf("#") > -1 && hasquery == true) {
		activeid = GetCookie("philotab");
		if (activeid) {
			sshow(activeid);
		}
	}
}


function setActiveTab(id) {

	SetCookie("philotab", id);

	var navlinks = document.getElementById("navlister").getElementsByTagName("li");
	for (i = 0; i < navlinks.length; i++) {
		if (navlinks[i].id == id + "li") {
			navlinks[i].className = "activenav";
		} else {
			navlinks[i].className = "";
		}
	}
}

function sshow(id) {
	if (document.getElementById(id).style.display == "block") {
		hideall();
		setActiveTab("none");
	} else {
		hideall();
		setActiveTab(id);
		var navlinks = document.getElementById("navlister").getElementsByTagName("li");
		for (i = 0; i < navlinks.length; i++) {
        	        if (navlinks[i].id == id + "li") {
                	        navlinks[i].className = "activenav";
                	} 
			else {
                        	navlinks[i].className = "";
                	}
        	}
		document.getElementById(id).style.display = 'block';
//		document.getElementById(id).style.border = "1px solid #242E55";
	}
}


function hide(id) {
	document.getElementById(id).style.display = 'none';
}

function hideall() {
        for (var i = 0; i < allids.length; i++) {
		hide(allids[i]);
	}
}


function formulateQuery() {
	var query = "";
	var subquery = "";

	fieldsets = document.getElementsByTagName('fieldset');

	for (i = 0; i < fieldsets.length; i++) {

	        inputs = fieldsets[i].getElementsByTagName('input');
		subquery = "";

		if (fieldsets[i].parentNode.id == "resultformat") {
			if (document.getElementById("OUTPUTTF").checked) {
				subquery = "Frequency by <blue>Title</blue>";
                        } else if (document.getElementById("kwic").checked) {
                                subquery = "Occurrences <blue>Line by Line [KWIC]</blue>";
                        } else if (document.getElementById("OUTPUTTFR").checked) {
                                subquery = "Frequency by <blue>Title</blue> per <blue>10,000</blue>";
			} else if (document.getElementById("OUTPUTHEAD").checked) {
				subquery = "Frequency by <blue>Head Object</blue>";
                        } else if (document.getElementById("OUTPUTAF").checked) {
                                subquery = "Frequency by <blue>Author</blue>";
				if (document.getElementById("AFTITLEDISP").checked) {
					subquery += ", <blue>(titles hidden)</blue";
				}
			} else if (document.getElementById("OUTPUTAFR").checked) {
                                subquery = "Frequency by <blue>Author</blue> per <blue>10,000</blue>";
                                if (document.getElementById("AFTITLEDISP").checked) {
                                        subquery += ", <blue>(titles hidden)</blue";
                                }
                        } else if (document.getElementById("OUTPUTDF").checked || document.getElementById("OUTPUTDFR").checked) {
				if (document.getElementById("OUTPUTDF").checked) {
                        	        subquery = "Frequency by <blue>Years</blue>, Year Group: ";
                        	} else if (document.getElementById("OUTPUTDFR").checked) { 
					subquery = "Frequency by <blue>Years</blue>,  per <blue>10,000</blue>, Year Group: ";
				}
				subquery += "<blue>" + document.getElementById("DFPERIOD").options[document.getElementById("DFPERIOD").selectedIndex].text + "</blue>";
				if (document.getElementById("DFTITLEDISP").checked) {
                                        subquery += " <blue>(titles hidden)</blue";
                                }
                        } else if (document.getElementById("OUTPUTPF").checked) {
				subquery = "<blue>Collocation Table</blue> Spanning ";
				subquery += "<blue>" + document.getElementById("POLESPAN").options[document.getElementById("POLESPAN").selectedIndex].text + "</blue> words";
 				if (document.getElementById("POLEFILTER").checked) {
                                        subquery += ", <blue>(filter off)</blue";
                                }
			} else if (document.getElementById("OUTPUTTR").checked) {
                                subquery = "<blue>Theme-Rheme</blue> Display: ";
                                subquery += "<blue>" + document.getElementById("THMPRTLIMIT").options[document.getElementById("THMPRTLIMIT").selectedIndex].text + "</blue>";
			} else if (document.getElementById("TRSORT").checked) {
                                subquery = "Sort by <blue>bibliography</blue>, Order by: ";
                                subquery += "<blue>" + document.getElementById("trsortorder").options[document.getElementById("trsortorder").selectedIndex].text + "</blue>";
			} else if (document.getElementById("OUTPUTSK").checked) {
				subquery = "<blue>KWIC sort by keyword</blue> and word to its ";
                                subquery += "<blue>" + document.getElementById("KWSS").options[document.getElementById("KWSS").selectedIndex].text + "</blue>, Display up to ";
                                subquery += "<blue>" + document.getElementById("KWSSPRLIM").options[document.getElementById("KWSSPRLIM").selectedIndex].text + "</blue> occurrences";
			}
		} else if (fieldsets[i].parentNode.id == "searchopt") {
			if (document.getElementById("conjpro").checked) {
				subquery = "Phrase separated by <blue>" + document.getElementById("phrasedistance").value + "</blue> words";
			} else if (document.getElementById("cj6").checked) {
				subquery = "Proximity Searching in the <blue>Same Sentence</blue>"
			} else if (document.getElementById("cj5").checked) {
				subquery = "Proximity Searching in the <blue>Same Paragraph</blue>";
			}
		} else if (fieldsets[i].parentNode.id != "mainbib") {
		 	for(j = 0; j < inputs.length; j++) {
				if (inputs[j].value != '' && inputs[j].type == "text" && inputs[j].value != "Terms") {
					subquery += inputs[j].label + " <blue>'" + inputs[j].value + "'</blue>, ";
				}
			} 
			if (fieldsets[i].parentNode.id == "bibfields") {
				inputs = document.getElementById('mainbibfs').getElementsByTagName('input');
				for(j = 0; j < inputs.length; j++) {
        	                        if (inputs[j].value != '' && inputs[j].type == "text" && inputs[j].value != "Terms") {
                	                        subquery += inputs[j].label + " <blue>'" + inputs[j].value + "'</blue>, ";
                        	        }
                        	}
			}
		}
		if (subquery != "") {
			 if (fieldsets[i].parentNode.id == "basicform") {
                                if (document.getElementById("etsim").checked) {
                                        subquery += " and <blue>similar words</blue>";
				}
			} else if (fieldsets[i].parentNode.id == "bibfields") {
                                subquery += "sort by <blue>" + document.getElementById("sortorder").options[document.getElementById("sortorder").selectedIndex].text + "</blue>";
			}

			subquery = subquery.replace(/,\s$/, "");
			if (fieldsets[i].parentNode.id != "maincontents") {
				//query += "<a href='#" + fieldsets[i].parentNode.id + "' onClick='show(this);' >" + fieldsets[i].title + "</a>: " + subquery + "<br>";
				query += "<a href='javascript:sshow(\"" + fieldsets[i].parentNode.id + "\")'>" + fieldsets[i].title + "</a>: " + subquery + "<br>";
			} else {
                                query += "<b>" + fieldsets[i].title + "</b>: " + subquery + "<br>";
			}
		}
	}
	if (query == "") {
		document.getElementById("querytext").innerHTML = "Enter search criteria to form a new search.";
		return false;
	} else {
                document.getElementById("querytext").innerHTML = query;
		return true;
	}
}

function addLabelProperties() {
	if ( typeof document.getElementsByTagName == 'undefined' ) return;
	var labels = document.getElementsByTagName( "label" );
	var label, i = j = 0;
	var elem;
	while ( label = labels[i++] ) {
		if ( typeof label.htmlFor == 'undefined' ) return;

		elem = document.getElementById(label.htmlFor);
		if ( typeof elem == 'undefined' ) {
			self.devError( [label.htmlFor], 'noLabel' );
		} else if ( typeof elem.length != 'undefined' && elem.length > 1 && elem.nodeName != 'SELECT' ) {	
			for ( j = 0; j < elem.length; j++ ) {
				elem.item( j ).label = label;
			}
		}
		elem.label = label.innerHTML;
		if (elem.type == "text" ) {
			elem.onkeyup = function () { formulateQuery() };
		} else if (elem.type == "radio" || elem.type == "checkbox") {
			elem.onclick = function () { formulateQuery() };
		} else if (elem.type == "select-one") {
                        elem.onchange = function () { formulateQuery(); };
		} 

	}
}		

