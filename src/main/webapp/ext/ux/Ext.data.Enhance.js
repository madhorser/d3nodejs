Ext.ns('Ext.data');
Ext.data.Enhance = {
    /**
     * 找出已被删除的记录
     * @param {Ext.data.Store} store
     * @return {Ext.data.Record[]}
     */
    getDeleteData: function(store) {
        var deleted = [];
        store.oldData.each(function(rec){
            if (store.indexOf(rec) == -1) {
                var d = rec.data;
                deleted.push({id:d.id, subId:d.subId});
            }
        });
        return deleted;
    },
    
    /**
     * 找出已被修改的记录
     * @param {Ext.data.Store} store
     * @return {Ext.data.Record[]}
     */
    getModifyData: function(store) {
        var modified = [];
        store.each(function(rec){
            if (store.oldData.indexOf(rec) >= 0) {
                if (rec.dirty) {
                    modified.push(rec.data);
                }
            }
        });
        return modified;
    },
    
    /**
     * 找出新增的记录
     * @param {Ext.data.Store} store
     * @return {Ext.data.Record[]}
     */
    getAddData: function(store) {
        var added = [];
        store.each(function(rec){
            if (store.oldData.indexOf(rec) == -1) {
                added.push(rec.data);
            }
        });
        return added;
    },
    
    /**
     * 执行store的commitChanges
     * @param {Ext.data.Store} store
     */
    commitChange: function(store) {
        store.commitChanges();
        store.oldData = store.data.clone(); //re-backup data
    }
    
};