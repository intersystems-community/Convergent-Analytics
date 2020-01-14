/// 002 Engine Condition Classification
Class CONVERGENCE.WEB.ENGINES Extends (Ens.BusinessProcessBPL, isc.py.ens.ProcessUtils)
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' component='1' height='2650' width='2000' >
<context>
<property name='modelclassname' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='pam' type='%DeepSee.extensions.clusters.PAM' instantiate='0' />
<property name='clara' type='%DeepSee.extensions.clusters.CLARA' instantiate='0' />
</context>
<sequence xend='200' yend='2000' >
<flow xpos='200' ypos='250' xend='200' yend='800' >
<sequence >
<code name='Fit PCA to Testing Set' xpos='200' ypos='400' >
<![CDATA[ set sc=##class(%DeepSee.extensions.components.PCA).process("User_WEB.ENGINES_EVEN","R01,R02,R03,R04,R05,R06,R07,R08,R09,R10,R11,R12,R13,R14,R15,R16,R17,R18,R19,R20,R21","PC01,PC02,PC03,PC04,PC05,PC06,PC07,PC08,PC09,PC10,PC11,PC12",.pcaeven,1,0)]]>
</code>
</sequence>
<sequence >
<code name='Fit PCA to Training Set' xpos='470' ypos='400' >
<![CDATA[ set sc=##class(%DeepSee.extensions.components.PCA).process("User_WEB.ENGINES_ODD","R01,R02,R03,R04,R05,R06,R07,R08,R09,R10,R11,R12,R13,R14,R15,R16,R17,R18,R19,R20,R21","PC01,PC02,PC03,PC04,PC05,PC06,PC07,PC08,PC09,PC10,PC11,PC12",.pcaodd,1,0)]]>
</code>
<code name='Prepare PAM' xpos='470' ypos='500' >
<![CDATA[ set sc=##class(%DeepSee.extensions.clusters.AbstractModel).Delete("ENGINES_ODD")
 set pam=##class(%DeepSee.extensions.clusters.PAM).New("ENGINES_ODD",.sc)
 set pam.Normalize=0
 set rs=##class(%ResultSet).%New("%DynamicQuery:SQL")
 set sc=rs.Prepare("SELECT * FROM User_WEB.ENGINES_ODD")
 set sc=rs.Execute()
 set sc=pam.SetData(rs,12)
 set sc=pam.Prepare()]]>
</code>
<code name='Train CLARA' xpos='470' ypos='600' >
<![CDATA[ set pam=context.pam
 set pam=##class(%DeepSee.extensions.clusters.CLARA).Open("ENGINES_ODD")
 set pam.SampleSize=400
 set pam.K=3
 set pam.Dim=12
 set pam.Verbose=-1
 set sc=pam.Execute()
 set count=pam.GetCount()
 for i=1:1:count { set cluster(i)=pam.GetCluster(i) }
 for key=1:1:count { set number=cluster(key) &sql(UPDATE User_WEB.ENGINES_ODD SET User_WEB.ENGINES_ODD.ClusterID=:number WHERE User_WEB.ENGINES_ODD.ID-20428=:key) }
 set context.clara=pam
]]>
</code>
<code name='Extract PMML' xpos='470' ypos='700' >
<![CDATA[ set pam=context.clara
 for i=1:1:3 { set clustername(i)=i }
 set sc=pam.GeneratePMML(.pmml, .clustername)
 set modelclassname = "PMML.ENGINESODD"
 set sc=pmml.%SaveToClass(modelclassname, 1, 1)
 set context.modelclassname=modelclassname]]>
</code>
</sequence>
</flow>
<code name='Apply CLARA' xpos='200' ypos='900' >
<![CDATA[ set modelclassname=context.modelclassname
 &sql(DELETE FROM %DeepSee_PMML_Utils.TempResult)
 set sc=##class(%DeepSee.PMML.Utils).%RunModelFromSQL(.testid, modelclassname,, "SELECT PC01,PC02,PC03,PC04,PC05,PC06,PC07,PC08,PC09,PC10,PC11,PC12,ClusterID FROM User_WEB.ENGINES_EVEN")
 &sql(UPDATE User_WEB.ENGINES_EVEN SET User_WEB.ENGINES_EVEN.ClusterID=%DeepSee_PMML_Utils.TempResult.PredictedValue FROM User_WEB.ENGINES_EVEN INNER JOIN %DeepSee_PMML_Utils.TempResult ON User_WEB.ENGINES_EVEN.ID-20834=%DeepSee_PMML_Utils.TempResult.TestRecordId WHERE %DeepSee_PMML_Utils.TempResult.TestId=:testid)]]>
</code>
<call name='Import Python Libraries' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1000' >
<annotation><![CDATA[def warn(*args, **kwargs): pass
import warnings
warnings.warn = warn
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import seaborn as sns
import warnings
warnings.filterwarnings('ignore', category=DeprecationWarning)
import pandas as pd]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Import Python Libraries&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<flow xpos='200' ypos='1100' xend='200' yend='1350' >
<sequence >
<call name='Query In Training Set' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1250' >
<annotation><![CDATA[SELECT * FROM User_WEB.ENGINES_ODD]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Training Set&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;Data_odd&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
<sequence >
<call name='Query In Testing Set' target='isc.py.ens.Operation' async='0' xpos='470' ypos='1250' >
<annotation><![CDATA[SELECT * FROM User_WEB.ENGINES_EVEN]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Testing Set&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;Data_even&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</flow>
<call name='Analyze Cycles and RUL' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1450' >
<annotation><![CDATA[Data0_odd=Data_odd.drop(['LINE','STAMP1','STAMP2'],axis=1)
Data0_odd['ENGINE'].replace('Engine_','',inplace=True,regex=True)
Data0_odd['ENGINE']=pd.to_numeric(Data0_odd['ENGINE'])
Data1_odd=Data0_odd.drop(['PARAM3','R01','R10','R16','R18','R19','R05'],axis=1)
Data2_odd=Data1_odd.groupby('ENGINE', as_index=False).CYCLE.max()
Data2_odd.columns=['ENGINE','FAILURE']
f=plt.figure()
plt.scatter(Data2_odd['ENGINE'],Data2_odd['FAILURE'])
plt.title('Engine ID/cycles run to failure')
plt.xlabel('Engine ID')
plt.ylabel('Cycle run to failure')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES001_odd.png')
plt.close(f)
f=plt.figure()
plt.hist(Data2_odd['FAILURE'],15)
plt.title('Cycles run to failure')
plt.xlabel('Cycles run to failure')
plt.ylabel('Number of engines')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES002_odd.png')
plt.close(f)
Data3_odd=Data1_odd.merge(Data2_odd,on=['ENGINE','ENGINE'],how='left')
Data3_odd['RUL']=Data3_odd['FAILURE']-Data3_odd['CYCLE']
Data0_even=Data_even.drop(['LINE','STAMP1','STAMP2'],axis=1)
Data0_even['ENGINE'].replace('Engine_','',inplace=True,regex=True)
Data0_even['ENGINE']=pd.to_numeric(Data0_even['ENGINE'])
Data1_even=Data0_even.drop(['PARAM3','R01','R10','R16','R18','R19','R05'],axis=1)
Data2_even=Data1_even.groupby('ENGINE', as_index=False).CYCLE.max()
Data2_even.columns=['ENGINE','FAILURE']
f=plt.figure()
plt.scatter(Data2_even['ENGINE'],Data2_even['FAILURE'])
plt.title('Engine ID/cycles run to failure')
plt.xlabel('Engine ID')
plt.ylabel('Cycles run to failure')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES001_even.png')
plt.close(f)
f=plt.figure()
plt.hist(Data2_even['FAILURE'],15)
plt.title('Cycles run to failure')
plt.xlabel('Cycles run to failure')
plt.ylabel('Number of engines')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES002_even.png')
plt.close(f)
Data3_even=Data1_even.merge(Data2_even,on=['ENGINE','ENGINE'],how='left')
Data3_even['RUL']=Data3_even['FAILURE']-Data3_even['CYCLE']]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Analyze Cycles and RUL&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Analyze Correlation' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1550' >
<annotation><![CDATA[Data4_odd=Data1_odd.drop(['ENGINE','CYCLE','ClusterID'],axis=1)
Data4_odd['R11']=pd.to_numeric(Data4_odd['R11'])
Data4_odd['R12']=pd.to_numeric(Data4_odd['R12'])
Data4_odd['R13']=pd.to_numeric(Data4_odd['R13'])
Data4_odd['R14']=pd.to_numeric(Data4_odd['R14'])
Data4_odd['R15']=pd.to_numeric(Data4_odd['R15'])
Data4_odd['R02']=pd.to_numeric(Data4_odd['R02'])
Data4_odd['R20']=pd.to_numeric(Data4_odd['R20'])
Data4_odd['R21']=pd.to_numeric(Data4_odd['R21'])
Data4_odd['R03']=pd.to_numeric(Data4_odd['R03'])
Data4_odd['R04']=pd.to_numeric(Data4_odd['R04'])
Data4_odd['R06']=pd.to_numeric(Data4_odd['R06'])
Data4_odd['R07']=pd.to_numeric(Data4_odd['R07'])
Data4_odd['R08']=pd.to_numeric(Data4_odd['R08'])
Data4_odd['R09']=pd.to_numeric(Data4_odd['R09'])
Data4_odd['PARAM1']=pd.to_numeric(Data4_odd['PARAM1'])
Data4_odd['PARAM2']=pd.to_numeric(Data4_odd['PARAM2'])
corrmat=Data4_odd.corr()
f=plt.figure()
sns.heatmap(corrmat,xticklabels=corrmat.columns,yticklabels=corrmat.columns)
plt.title("Correlation among the variables")
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES003_odd.png')
plt.close(f)
Data4_even=Data1_even.drop(['ENGINE','CYCLE','ClusterID'],axis=1)
Data4_even['R11']=pd.to_numeric(Data4_even['R11'])
Data4_even['R12']=pd.to_numeric(Data4_even['R12'])
Data4_even['R13']=pd.to_numeric(Data4_even['R13'])
Data4_even['R14']=pd.to_numeric(Data4_even['R14'])
Data4_even['R15']=pd.to_numeric(Data4_even['R15'])
Data4_even['R02']=pd.to_numeric(Data4_even['R02'])
Data4_even['R20']=pd.to_numeric(Data4_even['R20'])
Data4_even['R21']=pd.to_numeric(Data4_even['R21'])
Data4_even['R03']=pd.to_numeric(Data4_even['R03'])
Data4_even['R04']=pd.to_numeric(Data4_even['R04'])
Data4_even['R06']=pd.to_numeric(Data4_even['R06'])
Data4_even['R07']=pd.to_numeric(Data4_even['R07'])
Data4_even['R08']=pd.to_numeric(Data4_even['R08'])
Data4_even['R09']=pd.to_numeric(Data4_even['R09'])
Data4_even['PARAM1']=pd.to_numeric(Data4_even['PARAM1'])
Data4_even['PARAM2']=pd.to_numeric(Data4_even['PARAM2'])
corrmat=Data4_even.corr()
f=plt.figure()
sns.heatmap(corrmat,xticklabels=corrmat.columns,yticklabels=corrmat.columns)
plt.title("Correlation among the variables")
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES003_even.png')
plt.close(f)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Analyze Correlation&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<flow xpos='200' ypos='1650' xend='200' yend='1900' >
<sequence >
<call name='Visualize Training Set' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1800' >
<annotation><![CDATA[Data7_odd_engine01=Data3_odd.loc[Data3_odd['ENGINE']==1]
Data7_odd_engine47=Data3_odd.loc[Data3_odd['ENGINE']==47]
Data7_odd_engine99=Data3_odd.loc[Data3_odd['ENGINE']==99]
f=plt.figure()
plt.scatter(Data7_odd_engine01['CYCLE'],Data7_odd_engine01['R02'],c=Data7_odd_engine01['ClusterID'])
plt.title('Training set: sensor R02/engine 1')
plt.xlabel('Cycles run')
plt.ylabel('Sensor R02 readings')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES005_odd.png')
plt.close(f)
f=plt.figure()
plt.scatter(Data7_odd_engine47['CYCLE'],Data7_odd_engine47['R12'],c=Data7_odd_engine47['ClusterID'])
plt.title('Training set: sensor R12/engine 47')
plt.xlabel('Cycles run')
plt.ylabel('Sensor R12 readings')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES006_odd.png')
plt.close(f)
f=plt.figure()
plt.scatter(Data7_odd_engine99['CYCLE'],Data7_odd_engine99['R13'],c=Data7_odd_engine99['ClusterID'])
plt.title('Training set: sensor R13/engine 99')
plt.xlabel('Cycles run')
plt.ylabel('Sensor R13 readings')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES007_odd.png')
plt.close(f)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Visualize Training Set&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
<sequence >
<call name='Visualize Testing Set' target='isc.py.ens.Operation' async='0' xpos='470' ypos='1800' >
<annotation><![CDATA[Data8_even_engine02=Data3_even.loc[Data3_even['ENGINE']==2]
Data8_even_engine50=Data3_even.loc[Data3_even['ENGINE']==50]
Data8_even_engine100=Data3_even.loc[Data3_even['ENGINE']==100]
f=plt.figure()
plt.scatter(Data8_even_engine02['CYCLE'],Data8_even_engine02['R02'],c=Data8_even_engine02['ClusterID'])
plt.title('Testing set: sensor R02/engine 2')
plt.xlabel('Cycles run')
plt.ylabel('Sensor R02 readings')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES008_even.png')
plt.close(f)
f=plt.figure()
plt.scatter(Data8_even_engine50['CYCLE'],Data8_even_engine50['R12'],c=Data8_even_engine50['ClusterID'])
plt.title('Testing set: sensor R12/engine 50')
plt.xlabel('Cycles run')
plt.ylabel('Sensor R12 readings')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES009_even.png')
plt.close(f)
f=plt.figure()
plt.scatter(Data8_even_engine100['CYCLE'],Data8_even_engine100['R13'],c=Data8_even_engine100['ClusterID'])
plt.title('Testing set: sensor R13/engine 100')
plt.xlabel('Cycles run')
plt.ylabel('Sensor R13 readings')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\ENGINES010_even.png')
plt.close(f)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Visualize Testing Set&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
</flow>
</sequence>
</process>
}

}
