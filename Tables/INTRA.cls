/// 
Class User.WEB.INTRA Extends (%Persistent, %XML.Adaptor) [ ClassType = persistent, DdlAllowed, Final, Owner = {_SYSTEM}, ProcedureBlock, SqlRowIdPrivate, SqlTableName = INTRA ]
{

Property POINT As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 2 ];

Property TONS As %Library.Float [ SqlColumnNumber = 3 ];

Property CODEGROUP As %Library.String [ SqlColumnNumber = 4, SqlFieldName = CODE_GROUP ];

Property NAMEGROUP As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 5, SqlFieldName = NAME_GROUP ];

Property CODEITEM As %Library.String [ SqlColumnNumber = 6, SqlFieldName = CODE_ITEM ];

Property CODEORIGIN As %Library.String [ SqlColumnNumber = 7, SqlFieldName = CODE_ORIGIN ];

Property CODEDESTINATION As %Library.String [ SqlColumnNumber = 8, SqlFieldName = CODE_DESTINATION ];

Property WAGONOWNER As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 9, SqlFieldName = WAGON_OWNER ];

Property TONKMS1000 As %Library.Float [ SqlColumnNumber = 10 ];

Parameter USEEXTENTSET = 1;

Storage Default
{
<Data name="INTRADefaultData">
<Value name="1">
<Value>POINT</Value>
</Value>
<Value name="2">
<Value>TONS</Value>
</Value>
<Value name="3">
<Value>CODEGROUP</Value>
</Value>
<Value name="4">
<Value>NAMEGROUP</Value>
</Value>
<Value name="5">
<Value>CODEITEM</Value>
</Value>
<Value name="6">
<Value>CODEORIGIN</Value>
</Value>
<Value name="7">
<Value>CODEDESTINATION</Value>
</Value>
<Value name="8">
<Value>WAGONOWNER</Value>
</Value>
<Value name="9">
<Value>TONKMS1000</Value>
</Value>
</Data>
<DataLocation>^BDZ4.CO4Q.1</DataLocation>
<ExtentLocation>^BDZ4.CO4Q</ExtentLocation>
<IdLocation>^BDZ4.CO4Q.1</IdLocation>
<Index name="IDKEY">
<Location>^BDZ4.CO4Q.1</Location>
</Index>
<IndexLocation>^BDZ4.CO4Q.I</IndexLocation>
<StreamLocation>^BDZ4.CO4Q.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
