function setActiveStyleSheet(title) {
    var i,
        a,
        links = document.getElementsByTagName("link"),
        len = links.length;
    for (i = 0; i < len; i++) {
        a = links[i];
        if (a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {
            a.disabled = true;
            if (a.getAttribute("title") == title) a.disabled = false;
        }
    }
}

function getActiveStyleSheet() {
    var i,
        a,
        links = document.getElementsByTagName("link"),
        len = links.length;
    for (i = 0; i < len; i++) {
        a = links[i];
        if (a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title") && !a.disabled) {
            return a.getAttribute("title");
        }
    }
    return null;
}

function getPreferredStyleSheet() {
    var i,
        a,
        links = document.getElementsByTagName("link"),
        len = links.length;
    for (i = 0; i < len; i++) {
        a = links[i];
        if (a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("rel").indexOf("alt") == -1 && a.getAttribute("title")) {
            return a.getAttribute("title");
        }
    }
    return null;
}

function createCookie(name, value, days) {
	var expires;
    if (days) {
		var d = expiresDate(days);
        expires = "; expires=" + d.toGMTString();
    } else {
        expires = '';
    }
    document.cookie = name + '=' + value + expires + '; path=/';
}

function readCookie(name, value) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    var len = ca.length;
    for (var i = 0; i < len; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1, c.length);
        }
        if (c.indexOf(nameEQ) == 0) {
            return c.substring(nameEQ.length, c.length);
        }
    }
    return null;
}

function expiresDate(days) { 
	if (!days) {
		days = new Date();
	}
	var tempYear = days.getYear(); 
	var tempMonth = days.getMonth();
	var tempDay = days.getDate();
	if(tempDay != 1){
		if(tempMonth == 11){
			tempYear = tempYear + 1;
			tempMonth = 0;
		}else{
			tempMonth = tempMonth + 1;
		}
		tempDay = tempDay - 1;
	}else{
		switch(tempMonth){
			case 0:
			case 2:
			case 4:
			case 6:
			case 7:
			case 9:
			case 11:
				tempDay = 31;
				break;
			case 3:
			case 5:
			case 8:
			case 10:
				tempDay = 30;
				break;
			case 1:
				if(tempYear%4==0){
					tempDay = 29;
				}else{
					tempDay = 28;
				}
				break;
		}
	}
	if(tempDay<10){
		tempDay = '0'+tempDay;
	}
	var dateStringInRange = tempYear + '-' + (tempMonth < 10 ? '0'+ (tempMonth + 1) : (tempMonth + 1)) + '-' + tempDay;	
	var isoExp = /^\s*(\d{4})-(\d\d)-(\d\d)\s*$/,  
	   date = new Date(NaN), month,  
	   parts = isoExp.exec(dateStringInRange);  

	if(parts) {  
		month = +parts[2];  
		date.setFullYear(parts[1], month - 1, parts[3]);  
		if(month != date.getMonth() + 1) {  
			date.setTime(NaN);  
		}  
	}  
	return date;  
}  