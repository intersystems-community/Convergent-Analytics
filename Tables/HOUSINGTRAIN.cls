/// 
Class User.WEB.HOUSINGTRAIN Extends %Persistent [ ClassType = persistent, DdlAllowed, Final, Owner = {_SYSTEM}, ProcedureBlock, SqlRowIdPrivate, SqlTableName = HOUSING_TRAIN ]
{

Property ACCTID As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 2, SqlFieldName = ACCT_ID ];

Property DATEFROM As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 3, SqlFieldName = DATE_FROM ];

Property YEARFROM As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 4, SqlFieldName = YEAR_FROM ];

Property DISTRICT As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 5, SqlFieldName = DISTRICT ];

Property NBOFROOMS As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 6, SqlFieldName = NB_OF_ROOMS ];

Property NBOFSQMETERS As %Library.Double [ SqlColumnNumber = 7, SqlFieldName = NB_OF_SQ_METERS ];

Property FLOOR As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 8, SqlFieldName = FLOOR ];

Property FORMAT As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 9, SqlFieldName = FORMAT ];

Property PROPERTYYEAR As %Library.String(MAXLEN = 10) [ SqlColumnNumber = 10, SqlFieldName = PROPERTY_YEAR ];

Property PROPERTYFLOORS As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 11, SqlFieldName = PROPERTY_FLOORS ];

Property PROPERTYMATERIAL As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 12, SqlFieldName = PROPERTY_MATERIAL ];

Property PROPERTYCODE As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 13, SqlFieldName = PROPERTY_CODE ];

Property BILLED12 As %Library.Double [ SqlColumnNumber = 14, SqlFieldName = BILLED_12 ];

Property PAID12 As %Library.Double [ SqlColumnNumber = 15, SqlFieldName = PAID_12 ];

Property DEBT12 As %Library.Double [ SqlColumnNumber = 16, SqlFieldName = DEBT_12 ];

Property BILLED11 As %Library.Double [ SqlColumnNumber = 17, SqlFieldName = BILLED_11 ];

Property PAID11 As %Library.Double [ SqlColumnNumber = 18, SqlFieldName = PAID_11 ];

Property DEBT11 As %Library.Double [ SqlColumnNumber = 19, SqlFieldName = DEBT_11 ];

Property BILLED10 As %Library.Double [ SqlColumnNumber = 20, SqlFieldName = BILLED_10 ];

Property PAID10 As %Library.Double [ SqlColumnNumber = 21, SqlFieldName = PAID_10 ];

Property DEBT10 As %Library.Double [ SqlColumnNumber = 22, SqlFieldName = DEBT_10 ];

Property BILLED09 As %Library.Double [ SqlColumnNumber = 23, SqlFieldName = BILLED_09 ];

Property PAID09 As %Library.Double [ SqlColumnNumber = 24, SqlFieldName = PAID_09 ];

Property DEBT09 As %Library.Double [ SqlColumnNumber = 25, SqlFieldName = DEBT_09 ];

Property BILLED08 As %Library.Double [ SqlColumnNumber = 26, SqlFieldName = BILLED_08 ];

Property PAID08 As %Library.Double [ SqlColumnNumber = 27, SqlFieldName = PAID_08 ];

Property DEBT08 As %Library.Double [ SqlColumnNumber = 28, SqlFieldName = DEBT_08 ];

Property BILLED07 As %Library.Double [ SqlColumnNumber = 29, SqlFieldName = BILLED_07 ];

Property PAID07 As %Library.Double [ SqlColumnNumber = 30, SqlFieldName = PAID_07 ];

Property DEBT07 As %Library.Double [ SqlColumnNumber = 31, SqlFieldName = DEBT_07 ];

Property BILLED06 As %Library.Double [ SqlColumnNumber = 32, SqlFieldName = BILLED_06 ];

Property PAID06 As %Library.Double [ SqlColumnNumber = 33, SqlFieldName = PAID_06 ];

Property DEBT06 As %Library.Double [ SqlColumnNumber = 34, SqlFieldName = DEBT_06 ];

Property BILLED05 As %Library.Double [ SqlColumnNumber = 35, SqlFieldName = BILLED_05 ];

Property PAID05 As %Library.Double [ SqlColumnNumber = 36, SqlFieldName = PAID_05 ];

Property DEBT05 As %Library.Double [ SqlColumnNumber = 37, SqlFieldName = DEBT_05 ];

Property BILLED04 As %Library.Double [ SqlColumnNumber = 38, SqlFieldName = BILLED_04 ];

Property PAID04 As %Library.Double [ SqlColumnNumber = 39, SqlFieldName = PAID_04 ];

Property DEBT04 As %Library.Double [ SqlColumnNumber = 40, SqlFieldName = DEBT_04 ];

Property BILLED03 As %Library.Double [ SqlColumnNumber = 41, SqlFieldName = BILLED_03 ];

Property PAID03 As %Library.Double [ SqlColumnNumber = 42, SqlFieldName = PAID_03 ];

Property DEBT03 As %Library.Double [ SqlColumnNumber = 43, SqlFieldName = DEBT_03 ];

Property BILLED02 As %Library.Double [ SqlColumnNumber = 44, SqlFieldName = BILLED_02 ];

Property PAID02 As %Library.Double [ SqlColumnNumber = 45, SqlFieldName = PAID_02 ];

Property DEBT02 As %Library.Double [ SqlColumnNumber = 46, SqlFieldName = DEBT_02 ];

Property BILLED01 As %Library.Double [ SqlColumnNumber = 47, SqlFieldName = BILLED_01 ];

Property PAID01 As %Library.Double [ SqlColumnNumber = 48, SqlFieldName = PAID_01 ];

Property DEBT01 As %Library.Double [ SqlColumnNumber = 49, SqlFieldName = DEBT_01 ];

Property NBOFRESIDENTS As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 50, SqlFieldName = NB_OF_RESIDENTS ];

Property NBOFMEN As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 51, SqlFieldName = NB_OF_MEN ];

Property NBOFWOMEN As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 52, SqlFieldName = NB_OF_WOMEN ];

Property NBOFRETIRED As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 53, SqlFieldName = NB_OF_RETIRED ];

Property NBOFCHILDREN As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 54, SqlFieldName = NB_OF_CHILDREN ];

Property MEANAGE As %Library.Double [ SqlColumnNumber = 55, SqlFieldName = MEAN_AGE ];

Property NBOFCITYINFLUENCERS As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 56, SqlFieldName = NB_OF_CITY_INFLUENCERS ];

Property NBOFCITYPORTALUSERS As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 57, SqlFieldName = NB_OF_CITY_PORTAL_USERS ];

Property NBOFCITYAIDRECEIVERS As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 58, SqlFieldName = NB_OF_CITY_AID_RECEIVERS ];

Property NBOFCITYSOCIALCARDHOLDERS As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 59, SqlFieldName = NB_OF_CITY_SOCIAL_CARDHOLDERS ];

Property LEVELOVERALL As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 60, SqlFieldName = LEVEL_OVERALL ];

Property LEVELENVIRONMENT As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 61, SqlFieldName = LEVEL_ENVIRONMENT ];

Property LEVELSECURITY As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 62, SqlFieldName = LEVEL_SECURITY ];

Property LEVELFACILITIES As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 63, SqlFieldName = LEVEL_FACILITIES ];

/// Bitmap Extent Index auto-generated by DDL CREATE TABLE statement.  Do not edit the SqlName of this index.
Index DDLBEIndex [ Extent, SqlName = "%%DDLBEIndex", Type = bitmap ];

Parameter USEEXTENTSET = 1;

Storage Default
{
<Data name="HOUSINGTRAINDefaultData">
<Value name="1">
<Value>flsid</Value>
</Value>
<Value name="2">
<Value>flsopendate</Value>
</Value>
<Value name="3">
<Value>flsopenyear</Value>
</Value>
<Value name="4">
<Value>districtname</Value>
</Value>
<Value name="5">
<Value>roomcount</Value>
</Value>
<Value name="6">
<Value>flatstotal</Value>
</Value>
<Value name="7">
<Value>flatfloor</Value>
</Value>
<Value name="8">
<Value>flattype</Value>
</Value>
<Value name="9">
<Value>houseyob</Value>
</Value>
<Value name="10">
<Value>housefloors</Value>
</Value>
<Value name="11">
<Value>housematsten</Value>
</Value>
<Value name="12">
<Value>houseSeries</Value>
</Value>
<Value name="13">
<Value>bill12</Value>
</Value>
<Value name="14">
<Value>paid12</Value>
</Value>
<Value name="15">
<Value>debt12</Value>
</Value>
<Value name="16">
<Value>bill11</Value>
</Value>
<Value name="17">
<Value>paid11</Value>
</Value>
<Value name="18">
<Value>debt11</Value>
</Value>
<Value name="19">
<Value>bill10</Value>
</Value>
<Value name="20">
<Value>paid10</Value>
</Value>
<Value name="21">
<Value>debt10</Value>
</Value>
<Value name="22">
<Value>bill9</Value>
</Value>
<Value name="23">
<Value>paid9</Value>
</Value>
<Value name="24">
<Value>debt9</Value>
</Value>
<Value name="25">
<Value>bill8</Value>
</Value>
<Value name="26">
<Value>paid8</Value>
</Value>
<Value name="27">
<Value>debt8</Value>
</Value>
<Value name="28">
<Value>bill7</Value>
</Value>
<Value name="29">
<Value>paid7</Value>
</Value>
<Value name="30">
<Value>debt7</Value>
</Value>
<Value name="31">
<Value>bill6</Value>
</Value>
<Value name="32">
<Value>paid6</Value>
</Value>
<Value name="33">
<Value>debt6</Value>
</Value>
<Value name="34">
<Value>bill5</Value>
</Value>
<Value name="35">
<Value>paid5</Value>
</Value>
<Value name="36">
<Value>debt5</Value>
</Value>
<Value name="37">
<Value>bill4</Value>
</Value>
<Value name="38">
<Value>paid4</Value>
</Value>
<Value name="39">
<Value>debt4</Value>
</Value>
<Value name="40">
<Value>bill3</Value>
</Value>
<Value name="41">
<Value>paid3</Value>
</Value>
<Value name="42">
<Value>debt3</Value>
</Value>
<Value name="43">
<Value>bill2</Value>
</Value>
<Value name="44">
<Value>paid2</Value>
</Value>
<Value name="45">
<Value>debt2</Value>
</Value>
<Value name="46">
<Value>bill1</Value>
</Value>
<Value name="47">
<Value>paid1</Value>
</Value>
<Value name="48">
<Value>debt1</Value>
</Value>
<Value name="49">
<Value>citizencount</Value>
</Value>
<Value name="50">
<Value>malecount</Value>
</Value>
<Value name="51">
<Value>femalecount</Value>
</Value>
<Value name="52">
<Value>penscount</Value>
</Value>
<Value name="53">
<Value>childcount</Value>
</Value>
<Value name="54">
<Value>avgage</Value>
</Value>
<Value name="55">
<Value>agcount</Value>
</Value>
<Value name="56">
<Value>elkcount</Value>
</Value>
<Value name="57">
<Value>lgotcount</Value>
</Value>
<Value name="58">
<Value>skmcount</Value>
</Value>
<Value name="59">
<Value>ratesummary</Value>
</Value>
<Value name="60">
<Value>rateeco</Value>
</Value>
<Value name="61">
<Value>ratecrime</Value>
</Value>
<Value name="62">
<Value>rateedu</Value>
</Value>
</Data>
<Data name="HOUSINGTRAINDefaultData1">
<Subscript>"1"</Subscript>
<Value name="1">
<Value>ACCTID</Value>
</Value>
<Value name="2">
<Value>DATEFROM</Value>
</Value>
<Value name="3">
<Value>YEARFROM</Value>
</Value>
<Value name="4">
<Value>DISTRICT</Value>
</Value>
<Value name="5">
<Value>NBOFROOMS</Value>
</Value>
<Value name="6">
<Value>NBOFSQMETERS</Value>
</Value>
<Value name="7">
<Value>FLOOR</Value>
</Value>
<Value name="8">
<Value>FORMAT</Value>
</Value>
<Value name="9">
<Value>PROPERTYYEAR</Value>
</Value>
<Value name="10">
<Value>PROPERTYFLOORS</Value>
</Value>
<Value name="11">
<Value>PROPERTYMATERIAL</Value>
</Value>
<Value name="12">
<Value>PROPERTYCODE</Value>
</Value>
<Value name="13">
<Value>BILLED12</Value>
</Value>
<Value name="14">
<Value>PAID12</Value>
</Value>
<Value name="15">
<Value>DEBT12</Value>
</Value>
<Value name="16">
<Value>BILLED11</Value>
</Value>
<Value name="17">
<Value>PAID11</Value>
</Value>
<Value name="18">
<Value>DEBT11</Value>
</Value>
<Value name="19">
<Value>BILLED10</Value>
</Value>
<Value name="20">
<Value>PAID10</Value>
</Value>
<Value name="21">
<Value>DEBT10</Value>
</Value>
<Value name="22">
<Value>BILLED09</Value>
</Value>
<Value name="23">
<Value>PAID09</Value>
</Value>
<Value name="24">
<Value>DEBT09</Value>
</Value>
<Value name="25">
<Value>BILLED08</Value>
</Value>
<Value name="26">
<Value>PAID08</Value>
</Value>
<Value name="27">
<Value>DEBT08</Value>
</Value>
<Value name="28">
<Value>BILLED07</Value>
</Value>
<Value name="29">
<Value>PAID07</Value>
</Value>
<Value name="30">
<Value>DEBT07</Value>
</Value>
<Value name="31">
<Value>BILLED06</Value>
</Value>
<Value name="32">
<Value>PAID06</Value>
</Value>
<Value name="33">
<Value>DEBT06</Value>
</Value>
<Value name="34">
<Value>BILLED05</Value>
</Value>
<Value name="35">
<Value>PAID05</Value>
</Value>
<Value name="36">
<Value>DEBT05</Value>
</Value>
<Value name="37">
<Value>BILLED04</Value>
</Value>
<Value name="38">
<Value>PAID04</Value>
</Value>
<Value name="39">
<Value>DEBT04</Value>
</Value>
<Value name="40">
<Value>BILLED03</Value>
</Value>
<Value name="41">
<Value>PAID03</Value>
</Value>
<Value name="42">
<Value>DEBT03</Value>
</Value>
<Value name="43">
<Value>BILLED02</Value>
</Value>
<Value name="44">
<Value>PAID02</Value>
</Value>
<Value name="45">
<Value>DEBT02</Value>
</Value>
<Value name="46">
<Value>BILLED01</Value>
</Value>
<Value name="47">
<Value>PAID01</Value>
</Value>
<Value name="48">
<Value>DEBT01</Value>
</Value>
<Value name="49">
<Value>NBOFRESIDENTS</Value>
</Value>
<Value name="50">
<Value>NBOFMEN</Value>
</Value>
<Value name="51">
<Value>NBOFWOMEN</Value>
</Value>
<Value name="52">
<Value>NBOFRETIRED</Value>
</Value>
<Value name="53">
<Value>NBOFCHILDREN</Value>
</Value>
<Value name="54">
<Value>MEANAGE</Value>
</Value>
<Value name="55">
<Value>NBOFCITYINFLUENCERS</Value>
</Value>
<Value name="56">
<Value>NBOFCITYPORTALUSERS</Value>
</Value>
<Value name="57">
<Value>NBOFCITYAIDRECEIVERS</Value>
</Value>
<Value name="58">
<Value>NBOFCITYSOCIALCARDHOLDERS</Value>
</Value>
<Value name="59">
<Value>LEVELOVERALL</Value>
</Value>
<Value name="60">
<Value>LEVELENVIRONMENT</Value>
</Value>
<Value name="61">
<Value>LEVELSECURITY</Value>
</Value>
<Value name="62">
<Value>LEVELFACILITIES</Value>
</Value>
</Data>
<DataLocation>^BDZ4.BC6N.1</DataLocation>
<DefaultData>HOUSINGTRAINDefaultData1</DefaultData>
<ExtentLocation>^BDZ4.BC6N</ExtentLocation>
<IdLocation>^BDZ4.BC6N.1</IdLocation>
<Index name="DDLBEIndex">
<Location>^BDZ4.BC6N.2</Location>
</Index>
<Index name="IDKEY">
<Location>^BDZ4.BC6N.1</Location>
</Index>
<IndexLocation>^BDZ4.BC6N.I</IndexLocation>
<StreamLocation>^BDZ4.BC6N.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
