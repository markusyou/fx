//+------------------------------------------------------------------+
//|                                                        close.mq4 |
//|                      Copyright ?2004, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property library

#include <stdlib.mqh>

int error=0;
int assert=0;

void printAssertResul() {
	Print("Test:"+assert+"assert process,pass:"+(assert - error)+",fail:"+error);
}

void assertStringEqual(string unit,string s1,string s2) {
	assert ++ ;
	if (s1!=s2) {
		Print(unit + " :Assert Fail,s1=\"" + s1 + "\",s2=\"" + s2+"\"");
		error ++ ;
	}
}

void assertDoubleEqual(string unit,double d1,double d2) {
	assert ++ ;
	if (d1!=d2) {
		Print(unit + " :Assert Fail,d1=\"" + d1 + "\",d2=\"" + d2+"\"");
		error ++ ;
	}
}


void test_StringReplace() {
	string unit = "test_stdlib.test_StringReplace";
	assertStringEqual(unit,StringReplace("123","2","$"),"1$3");
	assertStringEqual(unit,StringReplace("123","1","$"),"$23");
	assertStringEqual(unit,StringReplace("123","3","$"),"12$");
	assertStringEqual(unit,StringReplace("123111123","123","$"),"$111$");
	assertStringEqual(unit,StringReplace("123123123","123","$"),"$$$");
	assertStringEqual(unit,StringReplace("123123123","2",""),"131313");
	assertStringEqual(unit,StringReplace("123123123","","111"),"123123123");
	assertStringEqual(unit,StringReplace("1232312323","123","1"),"123123");
	//assertStringEqual(unit,StringReplace("1232312323","123","111"),"测试错误");
}

void test_Round(){
	string unit = "test_stdlib.test_Round";
	assertDoubleEqual(unit,Round(1.23455,3),1.235);
	assertDoubleEqual(unit,Round(1.23455,4),1.2346);
	assertDoubleEqual(unit,Round(1.234554,5),1.23455);
	assertDoubleEqual(unit,Round(1.234555,5),1.23456);
	assertDoubleEqual(unit,Round(-1.234555,5),-1.23456);
	assertDoubleEqual(unit,Round(0.00000001,5),0);
	assertDoubleEqual(unit,Round((1.36979-1.36964),5),0.00015);	
}


int test_stdlib() {
	test_StringReplace();
	test_Round();
}






//+------------------------------------------------------------------+