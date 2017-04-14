jQuery.noConflict();
//复选按钮
function changValue(box, checkboxStyle) {
	if (box.checked) {
		jQuery("."+checkboxStyle).attr("checked", true);
	} else {
		jQuery("."+checkboxStyle).attr("checked", false);
	}
}
//单选按钮
function radioChangValue(radio) {
	if(radio.checked) {
		jQuery("input[type='radio']").attr("checked", false);
		radio.checked = true;
	}
}

//取消复选按钮选择
function cancelCheckbox(checkboxStyle) {
	jQuery("."+checkboxStyle).attr("checked", false);
	
}

//如果dataTable中的所有复选框都选中了，则全选复选框选中；如果dataTable中有一个复选框没有被选中，则全选复选框不选中
function checkboxControl(box, checkboxAllStyle, checkboxOneStyle) {
	if(!box.checked) {
		jQuery("."+checkboxAllStyle).attr("checked", false);
	} else {
		var currentPageAllCheckbox = jQuery("."+checkboxOneStyle);
		for(var i=0; i<currentPageAllCheckbox.length; i++) {
			if(!currentPageAllCheckbox[i].checked) {
				return;
			}
		}
		jQuery("."+checkboxAllStyle).attr("checked", true);
	}
}