function movePage(pageNumber) {
	var url = location.href;
	// http://localhost:8080/notice.do?&pageNum
	var testUrl ;
	var urlPost ;
	var urlIndex ;
	var endIndex;
	var strLengh;
	console.log(url);
	if(url.indexOf("?") == -1) {
		console.log(" ? 없을때");
		url += "?";
		url += "&pageNum=" + pageNumber;
	} else if(url.indexOf("pageNum=") > -1){
		var pre = url.substring(0, url.indexOf("?"));
		var post = url.substring(url.indexOf("?") + 1);
		var querys = post.split("&");
		url = pre + "?"; 
		var seperator = "";
		for(var i = 0; i < querys.length; i++) {
			if(querys[i].indexOf("pageNum=") > -1) {
				url += seperator + "pageNum=" + pageNumber;
			} else { 
				url += seperator + querys[i];
			}
			seperator = "&";
		} 
	} else {
		console.log(" ? 있는데, pageNum이 존재하지 않을때");
		url += "&pageNum=" + pageNumber;
	}
	location.href=url;
}