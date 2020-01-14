/// 005 Marketing Campaign Optimization
Class CONVERGENCE.WEB.CAMPAIGN Extends (Ens.BusinessProcessBPL, isc.py.ens.ProcessUtils)
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' component='1' height='2900' width='2000' >
<context>
<property name='scenariolist' type='%Integer' initialexpression='0' collection='list' instantiate='0' />
<property name='i' type='%Integer' initialexpression='0' instantiate='0' />
<property name='cm' type='%VarString' instantiate='0' />
<property name='writeback' type='%VarString' instantiate='0' />
</context>
<sequence xend='200' yend='2650' >
<call name='Import Python Libraries' target='isc.py.ens.Operation' async='0' xpos='200' ypos='250' >
<annotation><![CDATA[import numpy as np
np.random.seed(10)
import matplotlib
import matplotlib.pyplot as plt
from sklearn.datasets import make_classification
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import (RandomTreesEmbedding,RandomForestClassifier,GradientBoostingClassifier)
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import roc_curve
from sklearn.pipeline import make_pipeline
import pandas as pd
from sklearn.preprocessing import LabelEncoder
from pandas_ml import ConfusionMatrix
n_estimator = 10]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Import Python Libraries&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<flow xpos='200' ypos='350' xend='200' yend='800' >
<sequence >
<call name='Query In Testing Set' target='isc.py.ens.Operation' async='0' xpos='200' ypos='500' >
<annotation><![CDATA[SELECT ID, * FROM User_WEB.CAMPAIGN_APPLY]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Testing Set&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;Data_test&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Form Testing Set' target='isc.py.ens.Operation' async='0' xpos='200' ypos='600' >
<annotation><![CDATA[lb_EDUCATION_test = LabelEncoder()
lb_MARITAL_STATUS_test = LabelEncoder()
lb_RELATIONSHIP_test = LabelEncoder()
lb_RACE_test = LabelEncoder()
lb_GENDER_test = LabelEncoder()
lb_COUNTRY_OF_BIRTH_test = LabelEncoder()
Data_test["EDUCATION"] = lb_EDUCATION_test.fit_transform(Data_test["EDUCATION"])
Data_test["MARITAL_STATUS"] = lb_MARITAL_STATUS_test.fit_transform(Data_test["MARITAL_STATUS"])
Data_test["RELATIONSHIP"] = lb_RELATIONSHIP_test.fit_transform(Data_test["RELATIONSHIP"])
Data_test["RACE"] = lb_RACE_test.fit_transform(Data_test["RACE"])
Data_test["COUNTRY_OF_BIRTH"] = lb_COUNTRY_OF_BIRTH_test.fit_transform(Data_test["COUNTRY_OF_BIRTH"])
Data_test["GENDER"] = lb_GENDER_test.fit_transform(Data_test["GENDER"])
X_test=Data_test[["EDUCATION","MARITAL_STATUS","RELATIONSHIP","RACE","COUNTRY_OF_BIRTH","GENDER"]]
y_test=Data_test["RESPONSE"]]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Form Testing Set&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
<sequence >
<call name='Query In Training Set' target='isc.py.ens.Operation' async='0' xpos='470' ypos='500' >
<annotation><![CDATA[SELECT * FROM User_WEB.CAMPAIGN_TRAIN]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Training Set&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;Data_train&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Form Training Set' target='isc.py.ens.Operation' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[lb_EDUCATION_train = LabelEncoder()
lb_MARITAL_STATUS_train = LabelEncoder()
lb_RELATIONSHIP_train = LabelEncoder()
lb_RACE_train = LabelEncoder()
lb_GENDER_train = LabelEncoder()
lb_COUNTRY_OF_BIRTH_train = LabelEncoder()
Data_train["EDUCATION"] = lb_EDUCATION_train.fit_transform(Data_train["EDUCATION"])
Data_train["MARITAL_STATUS"] = lb_MARITAL_STATUS_train.fit_transform(Data_train["MARITAL_STATUS"])
Data_train["RELATIONSHIP"] = lb_RELATIONSHIP_train.fit_transform(Data_train["RELATIONSHIP"])
Data_train["RACE"] = lb_RACE_train.fit_transform(Data_train["RACE"])
Data_train["COUNTRY_OF_BIRTH"] = lb_COUNTRY_OF_BIRTH_train.fit_transform(Data_train["COUNTRY_OF_BIRTH"])
Data_train["GENDER"] = lb_GENDER_train.fit_transform(Data_train["GENDER"])
X_train=Data_train[["EDUCATION","MARITAL_STATUS","RELATIONSHIP","RACE","COUNTRY_OF_BIRTH","GENDER"]]
y_train=Data_train["RESPONSE"]]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Form Training Set&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Split Training Set' target='isc.py.ens.Operation' async='0' xpos='470' ypos='700' >
<annotation><![CDATA[X_train, X_train_lr, y_train, y_train_lr = train_test_split(X_train, y_train, test_size=0.5)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Split Training Set&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
</flow>
<flow xpos='200' ypos='900' xend='200' yend='1150' >
<sequence >
<call name='Initialize LR' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1000' >
<annotation><![CDATA[lm = LogisticRegression(solver='lbfgs', max_iter=1000)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Initialize LR&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
</flow>
<flow xpos='200' ypos='1250' xend='200' yend='1500' >
<sequence >
<call name='Fit/Apply RT + LR' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1400' >
<annotation><![CDATA[rt = RandomTreesEmbedding(max_depth=3, n_estimators=n_estimator,random_state=0)
pipeline = make_pipeline(rt, lm)
pipeline.fit(X_train, y_train)
y_pred_rt = pipeline.predict_proba(X_test)[:, 1]
y_eval_rt = pipeline.predict_proba(X_train)[:, 1]
fpr_rt_lm, tpr_rt_lm, _ = roc_curve(y_train, y_eval_rt,pos_label=1)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit/Apply RT + LR&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
<sequence >
<call name='Fit/Apply RF + LR' target='isc.py.ens.Operation' async='0' xpos='470' ypos='1400' >
<annotation><![CDATA[rf = RandomForestClassifier(max_depth=3, n_estimators=n_estimator)
rf_enc = OneHotEncoder(categories='auto')
rf.fit(X_train, y_train)
rf_enc.fit(rf.apply(X_train))
lm.fit(rf_enc.transform(rf.apply(X_train_lr)), y_train_lr)
y_pred_rf_lm = lm.predict_proba(rf_enc.transform(rf.apply(X_test)))[:, 1]
y_eval_rf_lm = lm.predict_proba(rf_enc.transform(rf.apply(X_train)))[:, 1]
fpr_rf_lm, tpr_rf_lm, _ = roc_curve(y_train, y_eval_rf_lm,pos_label=1)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit/Apply RF + LR&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
<sequence >
<call name='Fit/Apply GB + LR' target='isc.py.ens.Operation' async='0' xpos='740' ypos='1400' >
<annotation><![CDATA[grd = GradientBoostingClassifier(n_estimators=n_estimator)
grd_enc = OneHotEncoder(categories='auto')
grd.fit(X_train, y_train)
grd_enc.fit(grd.apply(X_train)[:, :, 0])
lm.fit(grd_enc.transform(grd.apply(X_train_lr)[:, :, 0]), y_train_lr)
y_pred_grd_lm = lm.predict_proba(grd_enc.transform(grd.apply(X_test)[:, :, 0]))[:, 1]
y_eval_grd_lm = lm.predict_proba(grd_enc.transform(grd.apply(X_train)[:, :, 0]))[:, 1]
fpr_grd_lm, tpr_grd_lm, _ = roc_curve(y_train, y_eval_grd_lm,pos_label=1)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit/Apply GB + LR&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
</flow>
<flow xpos='200' ypos='1600' xend='200' yend='1850' >
<sequence >
<call name='Fit/Apply RF' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1750' >
<annotation><![CDATA[y_pred_rf = rf.predict_proba(X_test)[:, 1]
y_eval_rf = rf.predict_proba(X_train)[:, 1]
fpr_rf, tpr_rf, _ = roc_curve(y_train, y_eval_rf,pos_label=1)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit/Apply RF&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
<sequence >
<call name='Fit/Apply GB' target='isc.py.ens.Operation' async='0' xpos='470' ypos='1750' >
<annotation><![CDATA[y_pred_grd = grd.predict_proba(X_test)[:, 1]
y_eval_grd = grd.predict_proba(X_train)[:, 1]
fpr_grd, tpr_grd, _ = roc_curve(y_train, y_eval_grd,pos_label=1)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit/Apply GB&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
</flow>
<call name='Visualize ROC Curves' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1950' >
<annotation><![CDATA[f=plt.figure()
plt.plot([0, 1], [0, 1], 'k--')
plt.plot(fpr_rt_lm, tpr_rt_lm, label='LR->RT')
plt.plot(fpr_rf_lm, tpr_rf_lm, label='LR->RF')
plt.plot(fpr_grd_lm, tpr_grd_lm, label='LR->GBT')
plt.plot(fpr_rf, tpr_rf, label='RF')
plt.plot(fpr_grd, tpr_grd, label='GBT')
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('ROC Curve')
plt.legend(loc='best')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\CAMPAIGN001.png')
plt.close(f)
f=plt.figure()
plt.xlim(0.2, 0.4)
plt.ylim(0.7, 1)
plt.plot([0, 1], [0, 1], 'k--')
plt.plot(fpr_rt_lm, tpr_rt_lm, label='LR->RT')
plt.plot(fpr_rf, tpr_rf, label='RF')
plt.plot(fpr_rf_lm, tpr_rf_lm, label='LR->RF')
plt.plot(fpr_grd, tpr_grd, label='GBT')
plt.plot(fpr_grd_lm, tpr_grd_lm, label='LR->GBT')
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('ROC Curve (Comparison)')
plt.legend(loc='best')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\CAMPAIGN002.png')
plt.close(f)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Visualize ROC Curves&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Calculate Confusion Matrix' target='isc.py.ens.Operation' async='0' xpos='200' ypos='2050' >
<annotation><![CDATA[y_eval_rt_binned=y_eval_rt>0.7
y_eval_rt_binned=y_eval_rt_binned.astype(int)
cm = ConfusionMatrix(y_train, y_eval_rt_binned)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Calculate Confusion Matrix&quot;)" action="set" />
<assign property="callrequest.Variables" value="&quot;cm&quot;" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' >
<assign property="context.cm" value="callresponse.Variables.GetAt(&quot;cm&quot;)" action="set" />
</response>
</call>
<assign name="Form Iteration Array" property="status" value="context.scenariolist.InsertList($lb(1,2,3,4,5))" action="set" xpos='200' ypos='2150' />
<foreach name='Audience/Gain Scenarios' property='context.scenariolist' key='context.i' xpos='200' ypos='2250' xend='200' yend='550' >
<call name='Pass Iterator to Python' target='isc.py.ens.Operation' async='0' xpos='200' ypos='250' >
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="&quot;i=&quot;_context.i" action="set" />
<assign property="callrequest.Variables" value="&quot;i&quot;" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<trace value='context.i' xpos='200' ypos='350' />
<call name='Evaluate Scenario' target='isc.py.ens.Operation' async='0' xpos='200' ypos='450' >
<annotation><![CDATA[revenue_per_contact=1.0-(i-1)*0.2
expense_per_contact=0.2+(i-1)*0.2
y_gain=y_pred_rt*revenue_per_contact-(1-y_pred_rt)*expense_per_contact
Y_analysis=pd.concat([pd.DataFrame(y_pred_rt, columns=["PROBABILITY"]),pd.DataFrame(y_gain, columns=["GAIN"])],axis=1)
if i==1:
    writeback=pd.concat([Data_test["ID"],Y_analysis],axis=1)
Y_analysis=Y_analysis.sort_values(by=["PROBABILITY"],ascending=False)
Y_analysis=Y_analysis.reset_index(drop=True)
y_pred_rt_analysis=Y_analysis["PROBABILITY"]
y_pred_rt_analysis_scaled=np.linspace(1,0,len(y_pred_rt))
y_gain_analysis=Y_analysis["GAIN"]
y_gain_analysis_cumsum=np.cumsum(y_gain_analysis)
y_gain_analysis_cumsum_max=np.amax(y_gain_analysis_cumsum)
y_gain_index=np.where(y_gain_analysis_cumsum==y_gain_analysis_cumsum_max)
f=plt.figure()
plt.plot(y_pred_rt_analysis,y_gain_analysis_cumsum, c='blue')
plt.plot([np.asscalar(y_pred_rt_analysis[y_gain_index[0]]),np.asscalar(y_pred_rt_analysis[y_gain_index[0]])],[0,np.asscalar(y_gain_analysis_cumsum_max)],c='red',linestyle='--')
plt.xlim(1,0)
plt.xlabel('Audience response probability')
plt.ylabel('Gain')
plt.title('Optimal campaign audience: rpc='+str(revenue_per_contact)+' epc='+str(expense_per_contact))
plt.legend(loc='best')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\CAMPAIGN0'+str(i)+'1.png')
plt.close(f)
f=plt.figure()
plt.plot(y_pred_rt_analysis_scaled,y_gain_analysis_cumsum, c='green')
plt.plot([np.asscalar(y_pred_rt_analysis_scaled[y_gain_index[0]]),np.asscalar(y_pred_rt_analysis_scaled[y_gain_index[0]])],[0,np.asscalar(y_gain_analysis_cumsum_max)],c='red',linestyle='--')
plt.xlim(1,0)
plt.xlabel('Audience reverse-sorted by response probability')
plt.ylabel('Gain')
plt.title('Optimal campaign audience: rpc='+str(revenue_per_contact)+' epc='+str(expense_per_contact))
plt.legend(loc='best')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\CAMPAIGN0'+str(i)+'2.png')
plt.close(f)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Evaluate Scenario&quot;)" action="set" />
<assign property="callrequest.SeparateLines" value="0" action="set" />
<assign property="callrequest.Variables" value="&quot;writeback&quot;" action="set" />
<assign property="callrequest.Serialization" value="&quot;JSON&quot;" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' >
<assign property="context.writeback" value="callresponse.Variables.GetAt(&quot;writeback&quot;)" action="set" />
</response>
</call>
</foreach>
<code name='Harvest Writeback' xpos='200' ypos='2350' >
<![CDATA[ set var={}.%FromJSON(context.writeback)
 set i=var."ID".%GetIterator()
 while i.%GetNext(.key,.line) { set wbid(key)=line }
 set i=var."PROBABILITY".%GetIterator()
 while i.%GetNext(.key,.line) { set wbprob(key)=line }
 set i=var."GAIN".%GetIterator()
 while i.%GetNext(.key,.line) { set wbgain(key)=line set prob=wbprob(key) set gain=wbgain(key) set id=wbid(key) &sql(UPDATE User_WEB.CAMPAIGN_APPLY SET RESPONSE=:prob, AMOUNT=:gain WHERE ID=:id) }]]>
</code>
<call name='Capture Context' target='isc.py.ens.Operation' async='0' xpos='200' ypos='2450' >
<request type='isc.py.msg.SaveRequest' >
<assign property="callrequest.Name" value="&quot;CAMPAIGNCaptureContext&quot;" action="set" />
<assign property="callrequest.Description" value="&quot;20190117-15:38&quot;" action="set" />
</request>
<response type='Ens.StringResponse' />
</call>
<code name='Harvest Context' xpos='200' ypos='2550' >
<![CDATA[ set v=context.cm
 set l=$listfromstring(v," ")
 for i=1:1:$listlength(l) { if $listdata(l,i)=1 { set li=$NUMBER($list(l,i)) if li'="" { set ^CAMPAIGNCM(i)=li } } }]]>
</code>
</sequence>
</process>
}

}
