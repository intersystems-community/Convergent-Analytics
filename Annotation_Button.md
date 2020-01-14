1. Enable [write-access](http://docs.intersystems.com/ens20151/csp/docbook/DocBook.UI.Page.cls?KEY=GSA_config#GSA_config_database_edit) to `ENSLIB` database via the Management Portal.
2. Open class `EnsPortal.BPLEditor`.
3. Find line (around 389):
```
<textarea id="aAnnotation" label="Annotation" rows="3" cols="35" 
onchange="zenPage.activityChange(1);" 
onkeyup="zenPage.textControlKeyUp(zenEvent,zenThis);" 
onkeydown="zenPage.textControlKeyDown(zenThis);"/>
```
4. Add line:

```
<image src="deepsee/zoom_16.png" 
onclick="zenPage.editPropertyValue('aAnnotation','code');" title="Edit value"/>
```
5. Wrap both lines with hgroup tag:

```
<hgroup> <textarea id="aAnnotation" label="Annotation" rows="3" cols="35" onchange="zenPage.activityChange(1);" onkeyup="zenPage.textControlKeyUp(zenEvent,zenThis);" onkeydown="zenPage.textControlKeyDown(zenThis);"/>

<image src="deepsee/zoom_16.png" onclick="zenPage.editPropertyValue('aAnnotation','code');" title="Edit value"/> </hgroup>
```
6. Compile `EnsPortal.BPLEditor`.
7. Make `ENSLIB` database read-only.
