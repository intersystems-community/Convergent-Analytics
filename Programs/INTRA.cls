/// 006 Rail Time Series Discovery
Class CONVERGENCE.WEB.INTRA Extends (Ens.BusinessProcessBPL, isc.py.ens.ProcessUtils)
{

Property ConnectionType As %String(MAXLEN = 4, VALUELIST = ",RAW,JDBC,ODBC") [ InitialExpression = "RAW" ];

Parameter SETTINGS = "ConnectionType:Basic";

Storage Default
{
<Data name="INTRADefaultData">
<Subscript>"INTRA"</Subscript>
<Value name="1">
<Value>ConnectionType</Value>
</Value>
</Data>
<DefaultData>INTRADefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' component='1' height='2050' width='2000' >
<context>
<property name='id' type='%String' instantiate='0' >
<annotation><![CDATA[id of the saved context]]></annotation>
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='df' type='%VarString' instantiate='0' />
</context>
<sequence xend='200' yend='1150' >
<call name='Import Python Libraries' target='isc.py.ens.Operation' async='0' xpos='200' ypos='250' >
<annotation><![CDATA[def warn(*args, **kwargs): pass
import warnings
warnings.warn = warn
import itertools
import numpy as np
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')
import pandas as pd
import statsmodels.api as sm
import matplotlib
matplotlib.rcParams['axes.labelsize'] = 14
matplotlib.rcParams['xtick.labelsize'] = 12
matplotlib.rcParams['ytick.labelsize'] = 12
matplotlib.rcParams['text.color'] = 'k'
import sys]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Import Python Libraries&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Query In Time Series' target='isc.py.ens.Operation' async='0' xpos='200' ypos='350' >
<annotation><![CDATA[SELECT POINT, SUM(TONS) AS TOTAL_TONS FROM User_WEB.INTRA WHERE CODE_GROUP='G02' GROUP BY POINT ORDER BY POINT ASC]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Time Series&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;df&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Histroric Time Series' target='isc.py.ens.Operation' async='0' xpos='200' ypos='450' >
<annotation><![CDATA[df=df.drop(['POINT'],axis=1)
index=pd.date_range(start='2014-01-31',end='2016-11-30',freq='M')
df.index = index
df['TOTAL_TONS']=pd.to_numeric(df['TOTAL_TONS'])
f=plt.figure()
plt.plot(df)
plt.title('Transported Tonnage')
plt.xlabel('Months')
plt.ylabel('Tons')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\INTRA001.png')
plt.close(f)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Histroric Time Series&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Decompose Time Series' target='isc.py.ens.Operation' async='0' xpos='200' ypos='550' >
<annotation><![CDATA[decomposition = sm.tsa.seasonal_decompose(df, model="additive", freq=12)
f=decomposition.plot()
f.savefig('D:\InterSystems\IRIS\CSP\convergence\INTRA002.png')]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Decompose Time Series&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Explore Modeling Space' target='isc.py.ens.Operation' async='0' xpos='200' ypos='650' >
<annotation><![CDATA[p = d = q = range(0, 2)
pdq = list(itertools.product(p, d, q))
seasonal_pdq = [(x[0], x[1], x[2], 6) for x in list(itertools.product(p, d, q))]
orig_stdout = sys.stdout
f = open('D:/InterSystems/IRIS/CSP/convergence/INTRA003.txt', 'w')
sys.stdout = f
print('Examples of parameter combinations for Seasonal ARIMA...')
print('SARIMAX: {} x {}'.format(pdq[1], seasonal_pdq[1]))
print('SARIMAX: {} x {}'.format(pdq[1], seasonal_pdq[2]))
print('SARIMAX: {} x {}'.format(pdq[2], seasonal_pdq[3]))
print('SARIMAX: {} x {}'.format(pdq[2], seasonal_pdq[4]))
for param in pdq:
    for param_seasonal in seasonal_pdq:
        mod = sm.tsa.statespace.SARIMAX(df, order=param, seasonal_order=param_seasonal, enforce_stationarity=False, enforce_invertibility=False)
        results = mod.fit()
        print('ARIMA{}x{}6 - AIC:{}'.format(param, param_seasonal, results.aic))
mod = sm.tsa.statespace.SARIMAX(df, order=(1, 1, 1), seasonal_order=(1, 1, 0, 6), enforce_stationarity=False, enforce_invertibility=False)
results = mod.fit()
print(results.summary().tables[1])
sys.stdout = orig_stdout
f.close()]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Explore Modeling Space&quot;)" action="set" />
<assign property="callrequest.SeparateLines" value="0" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Explore Selected Model' target='isc.py.ens.Operation' async='0' xpos='200' ypos='750' >
<annotation><![CDATA[f=results.plot_diagnostics()
f.savefig('D:\InterSystems\IRIS\CSP\convergence\INTRA004.png')]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Explore Selected Model&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Create Forecast' target='isc.py.ens.Operation' async='0' xpos='200' ypos='850' >
<annotation><![CDATA[pred = results.get_prediction(start=25, dynamic=False)
pred_ci = pred.conf_int()
plot=df['2014':].plot(label='observed')
pred.predicted_mean.plot(ax=plot, label='Forecast', alpha=.7, figsize=(14, 7))
plot.fill_between(pred_ci.index, pred_ci.iloc[:, 0], pred_ci.iloc[:, 1], color='k', alpha=.2)
plot.set_xlabel('Months')
plot.set_ylabel('Total Tons')
plot.legend()
f=plot.get_figure()
f.savefig('D:\InterSystems\IRIS\CSP\convergence\INTRA005.png')]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Create Forecast&quot;)" action="set" />
<assign property="callrequest.Variables" value="&quot;df&quot;" action="set" />
<assign property="callrequest.Serialization" value="&quot;JSON&quot;" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' >
<assign property="context.df" value="callresponse.Variables.GetAt(&quot;df&quot;)" action="set" />
</response>
</call>
<call name='Capture Context' target='isc.py.ens.Operation' async='0' xpos='200' ypos='950' >
<request type='isc.py.msg.SaveRequest' >
<assign property="callrequest.Name" value="&quot;INTRACaptureContext&quot;" action="set" />
<assign property="callrequest.Description" value="&quot;20190121-15:33&quot;" action="set" />
</request>
<response type='Ens.Response' >
<assign property="context.id" value="callresponse" action="set" />
</response>
</call>
<code name='Harvest Context' xpos='200' ypos='1050' >
<![CDATA[ set var = {}.%FromJSON(context.df)
 set i = var."TOTAL_TONS".%GetIterator()
 while i.%GetNext(.key,.line) { set ^INTRATS(key)=line }
 ]]>
</code>
</sequence>
</process>
}

}
