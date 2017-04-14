/**
 * 皮肤
 */
(function() {
	var theme = {
		/**
		 * 切换EasyUI theme
		 * 
		 * @param name
		 *            {String} Theme name
		 */
		switchTheme : function(name) {
			easyloader.theme = name;
			$.each($("link"), function(i, v) {
				var href = v["href"];
				if (href) {
					if (/(\easyui\/themes\/)[^icon]/.test(href)) {
						var hrefArr = href.split("/");
						hrefArr[hrefArr.length - 2] = name;
						v["href"] = hrefArr.join("/");
					}
				}
			});
		}
	};

	window["theme"] = theme;
})();