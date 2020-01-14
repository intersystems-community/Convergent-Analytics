/// 004 Retail Cannibalization Analysis
Class CONVERGENCE.WEB.CANNIBALIZATION Extends (Ens.BusinessProcessBPL, isc.py.ens.ProcessUtils)
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' component='1' height='2000' width='2000' >
<context>
<property name='x' type='%Integer' initialexpression='0' instantiate='0' />
<property name='yearlist' type='%String' collection='list' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
</context>
<sequence xend='200' yend='750' >
<call name='Import Python Libraries' target='isc.py.ens.Operation' async='0' xpos='200' ypos='250' >
<annotation><![CDATA[import matplotlib
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Import Python Libraries&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Query In Sampling Set' target='isc.py.ens.Operation' async='0' xpos='200' ypos='350' >
<annotation><![CDATA[SELECT * FROM User_WEB.CANNIBALIZATION_VOLUME_YEAR_WEEK_CATEGORY_DESC]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Sampling Set&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;Data&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Form Sampling Set' target='isc.py.ens.Operation' async='0' xpos='200' ypos='450' >
<annotation><![CDATA[Data0=Data.drop(["WEEK"],axis=1)
Data0["YEAR"]=pd.to_numeric(Data0["YEAR"])
Data0["BRATWURST"]=pd.to_numeric(Data0["BRATWURST"])
Data0["CERVELAS"]=pd.to_numeric(Data0["CERVELAS"])
Data0["CHARCUTERIE"]=pd.to_numeric(Data0["CHARCUTERIE"])
Data0["DAUERFLEISCHWAREN"]=pd.to_numeric(Data0["DAUERFLEISCHWAREN"])
Data0["GEFLUEGEL"]=pd.to_numeric(Data0["GEFLUEGEL"])
Data0["GERAEUCHERTES_ZUM_KOCHEN"]=pd.to_numeric(Data0["GERAEUCHERTES_ZUM_KOCHEN"])
Data0["HACKFLEISCH"]=pd.to_numeric(Data0["HACKFLEISCH"])
Data0["INNEREIEN_DIVERSES"]=pd.to_numeric(Data0["INNEREIEN_DIVERSES"])
Data0["KALB"]=pd.to_numeric(Data0["KALB"])
Data0["KANINCHEN"]=pd.to_numeric(Data0["KANINCHEN"])
Data0["LAMM"]=pd.to_numeric(Data0["LAMM"])
Data0["MARINADEN"]=pd.to_numeric(Data0["MARINADEN"])
Data0["PASTETEN_TERRINEN_STREICHWURST"]=pd.to_numeric(Data0["PASTETEN_TERRINEN_STREICHWURST"])
Data0["PFANNENFERTIGES"]=pd.to_numeric(Data0["PFANNENFERTIGES"])
Data0["PFERD"]=pd.to_numeric(Data0["PFERD"])
Data0["RIND"]=pd.to_numeric(Data0["RIND"])
Data0["SALAMI_ROHWURST_AM_STUECK"]=pd.to_numeric(Data0["SALAMI_ROHWURST_AM_STUECK"])
Data0["SCHINKEN"]=pd.to_numeric(Data0["SCHINKEN"])
Data0["SCHWEIN"]=pd.to_numeric(Data0["SCHWEIN"])
Data0["UEBRIGE_BRUEHWURST_STUECK"]=pd.to_numeric(Data0["UEBRIGE_BRUEHWURST_STUECK"])
Data0["WIENERLI_KNACKERLI_FRANKFURTERLI"]=pd.to_numeric(Data0["WIENERLI_KNACKERLI_FRANKFURTERLI"])]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Form Sampling Set&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<assign name="Form Iteration Array" property="status" value="context.yearlist.InsertList($lb(2013,2014,2015,2016))" action="set" xpos='200' ypos='550' />
<foreach name='Iterate' property='context.yearlist' key='context.x' xpos='200' ypos='650' xend='200' yend='550' >
<call name='Pass Iterator to Python' target='isc.py.ens.Operation' async='0' xpos='200' ypos='250' >
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="&quot;x=&quot;_context.x" action="set" />
<assign property="callrequest.Variables" value="&quot;x&quot;" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<trace value='context.x' xpos='200' ypos='350' />
<call name='Sample Correlation Matrix' target='isc.py.ens.Operation' async='0' xpos='200' ypos='450' >
<annotation><![CDATA[Data1=Data0.loc[Data0["YEAR"] == 2012+x]
Data2=Data1.drop(["YEAR"],axis=1)
corrmat=Data2.corr()
f=plt.figure()
sns.heatmap(corrmat,xticklabels=corrmat.columns,yticklabels=corrmat.columns)
plt.title("Correlation analysis of category sales volumes (by year/month)")
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\CANNIBALIZATION00'+str(x)+'.png')
plt.close(f)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Sample Correlation Matrix&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</foreach>
</sequence>
</process>
}

}
