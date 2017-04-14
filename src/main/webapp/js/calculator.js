// 资金求和
function sumAmountMoney(grid, column) {
    var sum = sumAmount(grid, column);
    if (sum === false) return false;
    var amt = Ext.util.Format.asMoney(sum);
    extInfo(Ext.AL.calculatorSumText + amt);
}

// 求和
function sumAmount(grid, column) {
    var sm = grid.getSelectionModel();
    if (!validGridSele(sm, {})) return false;
    var sum = 0;
    grid.getSelectionModel().each(function(record) {
        if (isNaN(record.get(column))) return true;
        sum = sum + record.get(column);
    });
    return sum;
}
