/// 
Class Demo.HL7.PharmaProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='450' >
<code name='Pharma Stats' xpos='200' ypos='250' >
<annotation><![CDATA[Calculate Pharma Stats]]></annotation>
<![CDATA[ set prescription = request.GetValueAt("ORCgrp(1).OBRuniongrp.OBRunion.RXO:1.2")
 do $increment(^Pharma(prescription))]]>
</code>
<call name='Send to Other_FileOperation' target='Other_FileOperation' async='1' xpos='200' ypos='350' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
