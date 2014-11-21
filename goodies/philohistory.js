
Here is the javascript required for search forms for handling
the cookie storage of identifiers which are used by philohistory.pl

In the header of the search form (or called if you want):

<SCRIPT LANGUAGE="JavaScript">
var cookiename = "PhiloLogicHistory";
var philohist = "http://thyme.uchicago.edu/cgi-bin/newphilo/philohistory.pl?";

function SetCookie(cookiename, thisid) {
      document.cookie = cookiename + "=" + thisid +
                        "; expires=01-01-2020" +
                        "; path=/";
      }

function GetCookie (name) {
        var arg = name + "=";
        var alen = arg.length;
        var clen = document.cookie.length;
        var i = 0;
        while (i < clen) {
                var j = i + alen;
                if (document.cookie.substring(i, j) == arg)
                        return getCookieVal (j);
                i = document.cookie.indexOf(" ", i) + 1;
                if (i == 0) break;
                }
        return null;
        }

function getCookieVal(offset) {
        var endstr = document.cookie.indexOf (";", offset);
        if (endstr == -1)
        endstr = document.cookie.length;
        return unescape(document.cookie.substring(offset, endstr));
        }
</SCRIPT>


And then when you want to print the messages on the search form:

<SCRIPT LANGUAGE="JavaScript">
    var thisid = GetCookie(cookiename);
    if (thisid == null) {
        var n = Math.random();
        var x = n.toString();
        var p = x.replace(/\./, "9");
        thisid = p.substr(2,10);
        SetCookie(cookiename, thisid);
        }
    document.write(' | | <input type=\"checkbox\" name=\"KEEPHISTORY\"' +
                    'value=\"' + thisid + '\">Keep History');
    document.write(' | | <a href=\"' + philohist + 'HISTORYFILE=' +
                     thisid + '\">Get History</a>');
</SCRIPT>


