//看是否有父亲对象，如果有找一下是否有显示loading的div了，如果有就用那个来显示loading信息了
var parentLoadingDivId = "parentLoading";
function getParentLoading(){
	var loadingObj = document.getElementById(parentLoadingDivId);
	if(loadingObj){
		return null;
	}
	var parentObj = this.parent;
	var count = 0;
	while(parentObj){
		var loadingObj = parentObj.document.getElementById(parentLoadingDivId);
		if(loadingObj){
			return parentObj;
		}else{
			parentObj = parentObj.parent;										
			count++;
			if(count>5){
				return null;
			}
		}
	}
	return this;
}

function show1(divId){
	var parent = getParentLoading();
	if(parent==undefined || parent=="null"){
		//jQuery("#loading").css("display","inline");
		var loadingObj = document.getElementById(divId);
		var left = document.body.clientWidth/2 - loadingObj.offsetWidth/2;
		var top = document.body.clientHeight/2-loadingObj.offsetHeight/2;
		if(top < 0){
			top = 0;
		}
		loadingObj.style.left = left;
		loadingObj.style.top = top;
		loadingObj.style.display = "inline";
	}else{
		parent.show();
	}
}

function hide1(divId){
	var parent = getParentLoading();
	if(parent==undefined || parent=="null"){
		jQuery("#"+divId).css("display","none");
	}else{
		parent.hide();
	}
}