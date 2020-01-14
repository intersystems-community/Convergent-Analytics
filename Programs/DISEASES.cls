/// 
Class CONVERGENCE.WEB.DISEASES Extends (Ens.BusinessProcessBPL, R.Ens.ProcessUtils)
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='1100' >
<flow xpos='200' ypos='250' xend='200' yend='600' >
<sequence >
<call name='Query In Nodes' target='R.Ens.Operation' async='0' xpos='200' ypos='400' >
<request type='R.Msg.AssignSQLRequest' >
<assign property="callrequest.Name" value="&quot;Nodes&quot;" action="set" />
<assign property="callrequest.SQL" value="&quot;SELECT NID, TRAFFIC, TYPE FROM User_WEB.DISEASES_NODES&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
<sequence >
<call name='Query In Incidence Matrix' target='R.Ens.Operation' async='0' xpos='470' ypos='400' >
<request type='R.Msg.AssignSQLRequest' >
<assign property="callrequest.Name" value="&quot;Links&quot;" action="set" />
<assign property="callrequest.SQL" value="&quot;SELECT NODE, L_BAR7, L_BNC11, L_BNR20, L_BSK5, L_BTD8, L_CDO8, L_FRJ5, L_GNO17, L_HRJ11, L_HSV5, L_JKS20, L_KMM17, L_NDG6, L_PTS4, L_SGA22, L_SYM6, L_TAL5, L_VMS8, L_VSS3, L_ZAL4 FROM User_WEB.DISEASES_MATRIX&quot;" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Prepare Incidence Matrix' target='R.Ens.Operation' async='0' xpos='470' ypos='500' >
<annotation><![CDATA[colnames(Links)[1]=""
Links=as.matrix(Links)]]></annotation>
<request type='R.Msg.VoidEvalRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Prepare Incidence Matrix&quot;)" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</flow>
<call name='Prepare Graph' target='R.Ens.Operation' async='0' xpos='200' ypos='700' >
<annotation><![CDATA[library(igraph)
Net= graph_from_incidence_matrix(Links)
V(Net)$traffic=0
Net.bp=bipartite.projection(Net)]]></annotation>
<request type='R.Msg.VoidEvalRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Prepare Graph&quot;)" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Visualize Graph' target='R.Ens.Operation' async='0' xpos='200' ypos='800' >
<annotation><![CDATA[V(Net)$label.cex=2
V(Net)$label.font=2
jpeg('D:/InterSystems/IRIS/CSP/convergence/DISEASES001.jpg',width=1500,height=1500,quality=75)
plot(Net.bp$proj1,vertex.label.color="black",vertex.label.dist=1,vertex.size=7,vertex.label=Nodes$NID[Nodes$TYPE==1])
dev.off()
jpeg('D:/InterSystems/IRIS/CSP/convergence/DISEASES002.jpg',width=1500,height=1500,quality=75)
plot(Net.bp$proj2,vertex.label.color="black",vertex.label.dist=1,vertex.size=7,vertex.label=Nodes$NID[Nodes$TYPE==2])
dev.off()
jpeg(filename='D:/InterSystems/IRIS/CSP/convergence/DISEASES003.jpg',width=1500,height=1500,quality=75)
V(Net)$color=c("steel blue","orange")[V(Net)$type+1]
V(Net)$shape=c("rectangle", "rectangle")[V(Net)$type+1]
V(Net)$label=""
V(Net)$label=Nodes$NID
plot(Net,vertex.label.color="white",vertex.size=20)
dev.off()]]></annotation>
<request type='R.Msg.VoidEvalRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Visualize Graph&quot;)" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Analyze Graph' target='R.Ens.Operation' async='0' xpos='200' ypos='900' >
<annotation><![CDATA[Degrees=degree(Net,mode="all")
jpeg(filename='D:/InterSystems/IRIS/CSP/convergence/DISEASES004.jpg',width=1500,height=1500,quality=75)
V(Net)$color=c("steel blue","orange")[V(Net)$type+1]
V(Net)$shape=c("circle", "circle")[V(Net)$type+1]
plot(Net,vertex.label.color="black",vertex.size=Degrees)
dev.off()
jpeg(filename='D:/InterSystems/IRIS/CSP/convergence/DISEASES005.jpg',width=1500,height=1500,quality=75)
hist(Degrees,breaks=1:vcount(Net)-1,main="Histogram of node degree")
dev.off()
sink('D:/InterSystems/IRIS/CSP/convergence/DISEASES006.txt',type="output")
vertex_attr(Net)
sink()]]></annotation>
<request type='R.Msg.VoidEvalRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Analyze Graph&quot;)" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='Detect Communities' target='R.Ens.Operation' async='0' xpos='200' ypos='1000' >
<annotation><![CDATA[CEB=cluster_edge_betweenness(Net)
jpeg(filename='D:/InterSystems/IRIS/CSP/convergence/DISEASES010.jpg',width=1500,height=1500,quality=75)
plot(CEB,Net)
dev.off()]]></annotation>
<request type='R.Msg.VoidEvalRequest' >
<assign property="callrequest.Code" value="process.GetAnnotation(&quot;Detect Communities&quot;)" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

}
