/**
 * Ext.ux.Whether，单实例，公共工具类。
 * Store object or Renderder function use to display yes/no by value 1/0/'y'/'n'/...
 * 用法：new Ext.ux.Whether(),new Ext.ux.Whether({yes:'1',no:'0'}),new Ext.ux.Whether(yes:'Y',no:'N')..
 * @singleton
 * @auther huanglp 2009-04-03
 */
Ext.ux.Whether = function(){
	return {
		yesText : "Yes",
        noText : "No",
        emptyText : "--Select--",
		
		/**
         * 是或否数据源Store构造。
         * @return {Ext.data.Store}
         */
		store : function(y,n,empty) {
            var yn = this.parse(y,n);
            var data = [[yn.no,yn.noText], [yn.yes,yn.yesText]];
            return new Ext.data.SimpleStore({
                fields: ['value', 'text'],
                data : (empty===true) ? [['',this.emptyText]].concat(data) : data
            });
        },
		
        /**
         * 表格的字段生成Function，Returns a rendering function。
         * @return {Function}
         */
        render : function(y,n) {
        	var yn = this.parse(y,n);
            return function(v) {
                if (v == yn.yes){ return yn.yesText;}
                return yn.noText;
            };
        },
        
        //private
        parse : function(y,n) {
        	y = Ext.isEmpty(y,true) ? '1' : y;
            n = Ext.isEmpty(n,true) ? '0' : n;
            return {yes:y, no:n, yesText:this.yesText, noText:this.noText};
        }
	};
}();
