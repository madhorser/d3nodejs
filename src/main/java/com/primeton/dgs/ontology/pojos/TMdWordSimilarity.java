package com.primeton.dgs.ontology.pojos;

public class TMdWordSimilarity {
private String id;//主键
private String comname;//参照的对比名字
private String name;//名字
private String  stablevalue;//表名对比相似性
private String  scloumvalue;//字段对比相似性
private String  namelength;//字段长度值
private String  nametype;//字段类型枚举0或者1
private String  nameisnull;//字段控制
private String comments;//列字段注释
private String tcomments;//表注释
private String tablename;//表名

private String type0 ="0";//类型0 VARCHAR
private String type1 ="0";//类型1 SMALLINT
private String type2 ="0";//类型2 DOUBLE
private String type3 ="0";//类型3 BIT
private String type4 ="0";//类型4 FLOAT
private String type5 ="0";//类型5 NVARCHAR
private String type6 ="0";//类型6 DATETIME
private String type7 ="0";//类型7 TEXT
private String type8 ="0";//类型8 CHAR
private String type9 ="0";//类型9 NUMBER
private String type10 ="0";//类型10 VARCHAR2
private String type11 ="0";//类型11 DATE
private String type12 ="0";//类型12 CHAR
private String type13 ="0";//类型13 TINYTEXT
private String type14 ="0";//类型14 VARBINARY
private String type15 ="0";//类型15 LONGTEXT
private String type16 ="0";//类型16 TINYINT
private String type17 ="0";//类型17 LONGBLOB
private String type18 ="0";//类型18 BIGINT
private String type19 ="0";//类型19 BLOB
private String type20 ="0";//类型20 DECIMAL
private String type21 ="0";//类型21 INT
private String type22 ="0";//类型22 MEDIUMTEXT








public String getType0() {
	return type0;
}
public void setType0(String type0) {
	this.type0 = type0;
}
public String getType1() {
	return type1;
}
public void setType1(String type1) {
	this.type1 = type1;
}
public String getType2() {
	return type2;
}
public void setType2(String type2) {
	this.type2 = type2;
}
public String getType3() {
	return type3;
}
public void setType3(String type3) {
	this.type3 = type3;
}
public String getType4() {
	return type4;
}
public void setType4(String type4) {
	this.type4 = type4;
}
public String getType5() {
	return type5;
}
public void setType5(String type5) {
	this.type5 = type5;
}
public String getType6() {
	return type6;
}
public void setType6(String type6) {
	this.type6 = type6;
}
public String getType7() {
	return type7;
}
public void setType7(String type7) {
	this.type7 = type7;
}
public String getType8() {
	return type8;
}
public void setType8(String type8) {
	this.type8 = type8;
}
public String getType9() {
	return type9;
}
public void setType9(String type9) {
	this.type9 = type9;
}
public String getType10() {
	return type10;
}
public void setType10(String type10) {
	this.type10 = type10;
}
public String getType11() {
	return type11;
}
public void setType11(String type11) {
	this.type11 = type11;
}
public String getType12() {
	return type12;
}
public void setType12(String type12) {
	this.type12 = type12;
}
public String getType13() {
	return type13;
}
public void setType13(String type13) {
	this.type13 = type13;
}
public String getType14() {
	return type14;
}
public void setType14(String type14) {
	this.type14 = type14;
}
public String getType15() {
	return type15;
}
public void setType15(String type15) {
	this.type15 = type15;
}
public String getType16() {
	return type16;
}
public void setType16(String type16) {
	this.type16 = type16;
}
public String getType17() {
	return type17;
}
public void setType17(String type17) {
	this.type17 = type17;
}
public String getType18() {
	return type18;
}
public void setType18(String type18) {
	this.type18 = type18;
}
public String getType19() {
	return type19;
}
public void setType19(String type19) {
	this.type19 = type19;
}
public String getType20() {
	return type20;
}
public void setType20(String type20) {
	this.type20 = type20;
}
public String getType21() {
	return type21;
}
public void setType21(String type21) {
	this.type21 = type21;
}
public String getType22() {
	return type22;
}
public void setType22(String type22) {
	this.type22 = type22;
}

public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getComname() {
	return comname;
}
public void setComname(String comname) {
	this.comname = comname;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getStablevalue() {
	return stablevalue;
}
public void setStablevalue(String stablevalue) {
	this.stablevalue = stablevalue;
}
public String getScloumvalue() {
	return scloumvalue;
}
public void setScloumvalue(String scloumvalue) {
	this.scloumvalue = scloumvalue;
}
public String getNamelength() {
	return namelength;
}
public void setNamelength(String namelength) {
	this.namelength = namelength;
}
public String getNametype() {
	return nametype;
}
public void setNametype(String nametype) {
	this.nametype = nametype;
}
public String getNameisnull() {
	return nameisnull;
}
public void setNameisnull(String nameisnull) {
	this.nameisnull = nameisnull;
}
public String getComments() {
	return comments;
}
public void setComments(String comments) {
	this.comments = comments;
}
public String getTcomments() {
	return tcomments;
}
public void setTcomments(String tcomments) {
	this.tcomments = tcomments;
}
public String getTablename() {
	return tablename;
}
public void setTablename(String tablename) {
	this.tablename = tablename;
}

public String getString(){
	return this.id+","+
	this.comname+","+
	this.name+","+
	this.stablevalue+","+
	this.scloumvalue+","+
	this.namelength+","+
	this.nametype+","+
	this.nameisnull+","+
	this.comments+","+
	this.tcomments+","+
	this.tablename+","+
	this.type0+","+
	this.type1+","+
	this.type2+","+
	this.type3+","+
	this.type4+","+
	this.type5+","+
	this.type6+","+
	this.type7+","+
	this.type8+","+
	this.type9+","+
	this.type10+","+
	this.type11+","+
	this.type12+","+
	this.type13+","+
	this.type14+","+
	this.type15+","+
	this.type16+","+
	this.type17+","+
	this.type18+","+
	this.type19+","+
	this.type20+","+
	this.type21+","+
	this.type22+"\n";
}

}
