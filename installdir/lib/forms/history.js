var thisid = GetCookie("PhiloLogicHistory");
var philohist = "XXXPHILOCGIXXX/philohistory.pl?";

if (thisid == null) {
        var n = Math.random();
        var x = n.toString();
        var p = x.replace(/\./, "9");
        thisid = p.substr(2,10);
        SetCookie("PhiloLogicHistory", thisid);
}


document.write('<input type=\"checkbox\" name=\"KEEPHISTORY\"' + 'value=\"' + thisid + '\"> ');
document.write('Keep history');
document.write(' &nbsp;&nbsp;&nbsp;<a href=\"' + philohist + 'HISTORYFILE=' + thisid + '\">Open Saved Searches</a> ');




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
        while (i < clen)
                {
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
