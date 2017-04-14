/**
 * 不统计分页工具栏。不提供总记录数的信息，根据返回的数据确定是否启用上页、下页功能。
 * @class Ext.ux.NostatPagingToolbar
 * @extends Ext.PagingToolbar
 * @author huanglp 2010年1月4日
 */
Ext.ux.NostatPagingToolbar = Ext.extend(Ext.PagingToolbar, {
	displayMsg : 'Displaying {0} - {1}',
	beforePageText : "Page",
	afterPageText : "",
	
	// over ride
	getPageData : function(){
		var count = this.store.getCount();
    	total = this.cursor + count;
    	total = (count == this.pageSize) ? total+1 : total;
        return {
            total : total,
            activePage : Math.ceil((this.cursor+this.pageSize)/this.pageSize),
            pages :  total < this.pageSize ? 1 : Math.ceil(total/this.pageSize)
        };
    }
	
});
Ext.reg('nostatpaging', Ext.ux.NostatPagingToolbar);