/// 003 Reimbursement Request Check
Class CONVERGENCE.WEB.RECORD Extends (Ens.BusinessProcessBPL, isc.py.ens.ProcessUtils)
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' component='1' height='2000' width='2000' >
<sequence xend='200' yend='1700' >
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
<annotation><![CDATA[SELECT * FROM User_WEB.RECORD_TEST]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Testing Set&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;Data_test&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Form Testing Set' target='isc.py.ens.Operation' async='0' xpos='200' ypos='600' >
<annotation><![CDATA[lb_ACT_TYPE_test = LabelEncoder()
lb_ACT_CODE_test = LabelEncoder()
lb_SPECIALITY_test = LabelEncoder()
Data_test["ACT_TYPE"] = lb_ACT_TYPE_test.fit_transform(Data_test["ACT_TYPE"])
Data_test["ACT_CODE"] = lb_ACT_CODE_test.fit_transform(Data_test["ACT_CODE"])
Data_test["SPECIALITY"] = lb_SPECIALITY_test.fit_transform(Data_test["SPECIALITY"])
Data_test["ADMNOTMED"]=pd.to_numeric(Data_test["ADMNOTMED"])
X_test=Data_test[["ACT_TYPE","ACT_CODE","PAY_QTY","ACT_QTY","SPECIALITY","ACTBEFORECASE","ACTAFTERCASE"]]
y_test=Data_test["ADMNOTMED"]]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Form Testing Set&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
<sequence >
<call name='Query In Training Set' target='isc.py.ens.Operation' async='0' xpos='470' ypos='500' >
<annotation><![CDATA[SELECT * FROM User_WEB.RECORD_TRAIN]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Training Set&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;Data_train&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Form Training Set' target='isc.py.ens.Operation' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[lb_ACT_TYPE_train = LabelEncoder()
lb_ACT_CODE_train = LabelEncoder()
lb_SPECIALITY_train = LabelEncoder()
Data_train["ACT_TYPE"] = lb_ACT_TYPE_train.fit_transform(Data_train["ACT_TYPE"])
Data_train["ACT_CODE"] = lb_ACT_CODE_train.fit_transform(Data_train["ACT_CODE"])
Data_train["SPECIALITY"] = lb_SPECIALITY_train.fit_transform(Data_train["SPECIALITY"])
Data_train["ADMNOTMED"]=pd.to_numeric(Data_train["ADMNOTMED"])
X_train=Data_train[["ACT_TYPE","ACT_CODE","PAY_QTY","ACT_QTY","SPECIALITY","ACTBEFORECASE","ACTAFTERCASE"]]
y_train=Data_train["ADMNOTMED"]]]></annotation>
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
<call name='Fit/Apply RF + LR' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1050' >
<annotation><![CDATA[rf = RandomForestClassifier(max_depth=3, n_estimators=n_estimator)
rf_enc = OneHotEncoder(categories='auto')
rf_lm = LogisticRegression(solver='lbfgs', max_iter=1000)
rf.fit(X_train, y_train)
rf_enc.fit(rf.apply(X_train))
rf_lm.fit(rf_enc.transform(rf.apply(X_train_lr)), y_train_lr)
y_pred_rf_lm = rf_lm.predict_proba(rf_enc.transform(rf.apply(X_test)))[:, 1]
fpr_rf_lm, tpr_rf_lm, _ = roc_curve(y_test, y_pred_rf_lm)
y_pred_rf_lm_binned=y_pred_rf_lm>0.6
y_pred_rf_lm_binned=y_pred_rf_lm_binned.astype(int)
cm = ConfusionMatrix(y_test, y_pred_rf_lm_binned)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit/Apply RF + LR&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
<sequence >
<call name='Fit/Apply GB + LR' target='isc.py.ens.Operation' async='0' xpos='470' ypos='1050' >
<annotation><![CDATA[grd = GradientBoostingClassifier(n_estimators=n_estimator)
grd_enc = OneHotEncoder(categories='auto')
grd_lm = LogisticRegression(solver='lbfgs', max_iter=1000)
grd.fit(X_train, y_train)
grd_enc.fit(grd.apply(X_train)[:, :, 0])
grd_lm.fit(grd_enc.transform(grd.apply(X_train_lr)[:, :, 0]), y_train_lr)
y_pred_grd_lm = grd_lm.predict_proba(grd_enc.transform(grd.apply(X_test)[:, :, 0]))[:, 1]
fpr_grd_lm, tpr_grd_lm, _ = roc_curve(y_test, y_pred_grd_lm)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit/Apply GB + LR&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
<sequence >
<call name='Fit/Apply RT + LR' target='isc.py.ens.Operation' async='0' xpos='740' ypos='1050' >
<annotation><![CDATA[rt = RandomTreesEmbedding(max_depth=3, n_estimators=n_estimator,random_state=0)
rt_lm = LogisticRegression(solver='lbfgs', max_iter=1000)
pipeline = make_pipeline(rt, rt_lm)
pipeline.fit(X_train, y_train)
y_pred_rt = pipeline.predict_proba(X_test)[:, 1]
fpr_rt_lm, tpr_rt_lm, _ = roc_curve(y_test, y_pred_rt)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit/Apply RT + LR&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
</flow>
<flow xpos='200' ypos='1250' xend='200' yend='1500' >
<sequence >
<call name='Fit/Apply RF' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1400' >
<annotation><![CDATA[y_pred_rf = rf.predict_proba(X_test)[:, 1]
fpr_rf, tpr_rf, _ = roc_curve(y_test, y_pred_rf)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit/Apply RF&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
<sequence >
<call name='Fit/Apply GB' target='isc.py.ens.Operation' async='0' xpos='470' ypos='1400' >
<annotation><![CDATA[y_pred_grd = grd.predict_proba(X_test)[:, 1]
fpr_grd, tpr_grd, _ = roc_curve(y_test, y_pred_grd)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit/Apply GB&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
</flow>
<call name='Visualize' target='isc.py.ens.Operation' async='0' xpos='200' ypos='1600' >
<annotation><![CDATA[f=plt.figure()
plt.plot([0, 1], [0, 1], 'k--')
plt.plot(fpr_rt_lm, tpr_rt_lm, label='LR->RT')
plt.plot(fpr_rf, tpr_rf, label='RF')
plt.plot(fpr_rf_lm, tpr_rf_lm, label='LR->RF')
plt.plot(fpr_grd, tpr_grd, label='GBT')
plt.plot(fpr_grd_lm, tpr_grd_lm, label='LR->GBT')
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('ROC Curve')
plt.legend(loc='best')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\RECORD001.png')
plt.close(f)
f=plt.figure()
plt.xlim(0, 0.2)
plt.ylim(0.8, 1)
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
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\RECORD002.png')
plt.close(f)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Visualize&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
</process>
}

}
