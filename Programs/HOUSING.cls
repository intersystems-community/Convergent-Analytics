/// 007 Housing Debts Prediction
Class CONVERGENCE.WEB.HOUSING Extends (Ens.BusinessProcessBPL, isc.py.ens.ProcessUtils)
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' component='1' height='2000' width='2000' >
<sequence xend='200' yend='850' >
<call name='Import Python Libraries' target='isc.py.ens.Operation' async='0' xpos='200' ypos='250' >
<annotation><![CDATA[import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from statsmodels.graphics.gofplots import qqplot_2samples
from sklearn import linear_model
from sklearn.model_selection import train_test_split
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from statsmodels.graphics.gofplots import qqplot_2samples
from sklearn import linear_model
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Import Python Libraries&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Query In Training Set' target='isc.py.ens.Operation' async='0' xpos='200' ypos='350' >
<annotation><![CDATA[SELECT * FROM User_WEB.HOUSING_TRAIN]]></annotation>
<request type='isc.py.msg.QueryRequest' >
<assign property="callrequest.Query" value="process.GetAnnotation(&quot;Query In Training Set&quot;)" action="set" />
<assign property="callrequest.Variable" value="&quot;Data_y_known&quot;" action="set" />
<assign property="callrequest.Type" value="&quot;dataframe&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Fit LR Model' target='isc.py.ens.Operation' async='0' xpos='200' ypos='450' >
<annotation><![CDATA[X_y_known=Data_y_known[['DEBT_11','DEBT_10','DEBT_09','DEBT_08','DEBT_07','DEBT_06','DEBT_05','DEBT_04','DEBT_03','DEBT_02','DEBT_01']]
y_y_known=Data_y_known['DEBT_12']
X_train, X_eval, y_train, y_eval = train_test_split(X_y_known, y_y_known, test_size=0.2)
Model=linear_model.LinearRegression()
Model.fit(X_train,y_train)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Fit LR Model&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Apply LR Model' target='isc.py.ens.Operation' async='0' xpos='200' ypos='550' >
<annotation><![CDATA[y_pred=Model.predict(X_eval)
y_evalplot=pd.to_numeric(y_eval)
y_predplot=pd.DataFrame(y_pred)]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Apply LR Model&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Visualize Prediction Quality' target='isc.py.ens.Operation' async='0' xpos='200' ypos='650' >
<annotation><![CDATA[f=plt.figure()
plt.scatter(y_evalplot,y_predplot)
plt.xlabel('Actual debt')
plt.ylabel('Predicted debt')
plt.title('Predicted vs. actual debt')
f.savefig(r'D:\InterSystems\IRIS\CSP\convergence\HOUSING001.png')]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Visualize Prediction Quality&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
<call name='Harvest PMML' target='isc.py.ens.Operation' async='0' xpos='200' ypos='750' >
<annotation><![CDATA[Model = Pipeline([('lr',linear_model.LinearRegression())])
Model.fit(X_train,y_train)
features=X_train.columns
predicted='debt_12'
from nyoka import skl_to_pmml
skl_to_pmml(Model, features, predicted, 'D:/InterSystems/IRIS/CSP/convergence/HOUSING.pmml')]]></annotation>
<request type='isc.py.msg.ExecutionRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Harvest PMML&quot;)" action="set" />
</request>
<response type='isc.py.msg.ExecutionResponse' />
</call>
</sequence>
</process>
}

}
