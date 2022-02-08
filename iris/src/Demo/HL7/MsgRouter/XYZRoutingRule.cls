/// 
/// Routing from the XYZ message source.
Class Demo.HL7.MsgRouter.XYZRoutingRule Extends Ens.Rule.Definition [ ProcedureBlock ]
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.HL7.MsgRouter.RoutingEngine" production="Demo.HL7.MsgRouter.Production">
<ruleSet name="Rules for XYZ application messages" effectiveBegin="" effectiveEnd="">
<rule name="Check last name in 2.3.1 ADT_A08">
<constraint name="docCategory" value="2.3.1"></constraint>
<constraint name="docName" value="ADT_A08"></constraint>
<when condition="(HL7.{PID:PatientName(1).familylastname} Contains &quot;TEST&quot;)||(HL7.{PID:PatientName(1).familylastname} StartsWith &quot;ZZZ&quot;)">
<send transform="Demo.HL7.MsgRouter.ADTLastNameTransform" target="Other_FileOperation"></send>
<return></return>
</when>
</rule>
<rule name="Check last name in demo schema ORM_O01">
<constraint name="docCategory" value="Demo.HL7.MsgRouter.Schema"></constraint>
<constraint name="docName" value="ORM_O01"></constraint>
<when condition="1">
<send transform="Demo.HL7.MsgRouter.ORMLastNameTransform" target="Pharma Process"></send>
<return></return>
</when>
</rule>
<rule name="Match any demo schema message">
<constraint name="docCategory" value="Demo.HL7.MsgRouter.Schema"></constraint>
<when condition="1">
<send transform="" target="Regular_FileOperation"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
