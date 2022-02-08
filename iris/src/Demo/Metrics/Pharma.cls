Class Demo.Metrics.Pharma Extends %SYS.Monitor.SAM.Abstract
{

Parameter PRODUCT = "pharma";

/// Collect metrics
/// 
/// IMPORTANT! GetSensors() must have an efficient implementation (avoid hangs or timeouts)
Method GetSensors() As %Status
{
   set presc=""
   for {
      set presc = $order(^Pharma(presc))
      quit:presc=""
      
      do ..SetSensor("prescription", $get(^Pharma(presc)), presc)
   }
   return $$$OK
}

}
