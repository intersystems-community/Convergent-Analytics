/// 
Class User.WEB.CAMPAIGNTRAIN Extends %Persistent [ ClassType = persistent, DdlAllowed, Final, Owner = {slukyanc}, ProcedureBlock, SqlRowIdPrivate, SqlTableName = CAMPAIGN_TRAIN ]
{

Property AGE As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 3 ];

Property EDUCATION As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 5 ];

Property MARITALSTATUS As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 7, SqlFieldName = MARITAL_STATUS ];

Property OCCUPATION As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 8 ];

Property RELATIONSHIP As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 9 ];

Property RACE As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 10 ];

Property GENDER As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 11 ];

Property PROSPECTID As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 18, SqlFieldName = PROSPECT_ID ];

Property EMPLOYMENT As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 19 ];

Property YEARSEDUC As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 20, SqlFieldName = YEARS_EDUC ];

Property COUNTRYOFBIRTH As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 21, SqlFieldName = COUNTRY_OF_BIRTH ];

Property INVEARNINGS As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 22, SqlFieldName = INV_EARNINGS ];

Property INVLOSSES As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 23, SqlFieldName = INV_LOSSES ];

Property WORKWEEKLENGTH As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 24, SqlFieldName = WORKWEEK_LENGTH ];

Property RESPONSE As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 25 ];

Property AMOUNT As %Library.Double [ SqlColumnNumber = 26 ];

/// Bitmap Extent Index auto-generated by DDL CREATE TABLE statement.  Do not edit the SqlName of this index.
Index DDLBEIndex [ Extent, SqlName = "%%DDLBEIndex", Type = bitmap ];

Parameter USEEXTENTSET = 1;

Storage Default
{
<Data name="CAMPAIGNTRAINDefaultData">
<Value name="1"/>
<Value name="2">
<Value>AGE</Value>
</Value>
<Value name="3"/>
<Value name="4">
<Value>EDUCATION</Value>
</Value>
<Value name="5"/>
<Value name="6">
<Value>MARITALSTATUS</Value>
</Value>
<Value name="7">
<Value>OCCUPATION</Value>
</Value>
<Value name="8">
<Value>RELATIONSHIP</Value>
</Value>
<Value name="9">
<Value>RACE</Value>
</Value>
<Value name="10">
<Value>GENDER</Value>
</Value>
<Value name="11"/>
<Value name="12"/>
<Value name="13"/>
<Value name="14"/>
<Value name="15"/>
<Value name="16"/>
<Value name="17">
<Value>PROSPECTID</Value>
</Value>
<Value name="18">
<Value>EMPLOYMENT</Value>
</Value>
<Value name="19">
<Value>YEARSEDUC</Value>
</Value>
<Value name="20">
<Value>COUNTRYOFBIRTH</Value>
</Value>
<Value name="21">
<Value>INVEARNINGS</Value>
</Value>
<Value name="22">
<Value>INVLOSSES</Value>
</Value>
<Value name="23">
<Value>WORKWEEKLENGTH</Value>
</Value>
<Value name="24">
<Value>RESPONSE</Value>
</Value>
<Value name="25">
<Value>AMOUNT</Value>
</Value>
</Data>
<DataLocation>^BDZ4.iB0g.1</DataLocation>
<ExtentLocation>^BDZ4.iB0g</ExtentLocation>
<IdLocation>^BDZ4.iB0g.1</IdLocation>
<Index name="DDLBEIndex">
<Location>^BDZ4.iB0g.2</Location>
</Index>
<Index name="IDKEY">
<Location>^BDZ4.iB0g.1</Location>
</Index>
<IndexLocation>^BDZ4.iB0g.I</IndexLocation>
<StreamLocation>^BDZ4.iB0g.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
