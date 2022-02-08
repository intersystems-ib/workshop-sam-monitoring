/// An example Alert Handler class, which writes messages to the messages log.
Class Demo.AlertHandler Extends %SAM.AbstractAlertsHandler
{

/*
HandleAlerts() method receives a %DynamicArray packet of alerts with the following format:

[
  {
    "labels":{
      "alertname":"High CPU Usage",
      "cluster":"1",
      "instance":"10.0.0.24:9092",
      "job":"SAM",
      "severity":"critical"
    },
    "annotations":{
      "description":"CPU usage exceeded the 95% threshold."
    },
    "ts": "2020-04-17 18:07:42.536"
  },
  {
    "labels":{
      "alertname":"iris_system_alert",
      "cluster":"1",
      "instance":"10.0.0.24:9092",
      "job":"SAM",
      "severity":"critical"
    },
    "annotations":{
      "description":"Previous system shutdown was abnormal, system forced down or crashed"
    },
    "ts":"2020-04-17 18:07:36.926"
  }
]
*/
/// 
/// HandlerAlerts() implements behaviour when an alert fires
/// You can use this handler to send messages using Telegram, email, etc.
/// 
ClassMethod HandleAlerts(packet As %DynamicArray) As %Status
{
    set iter = packet.%GetIterator()
    while iter.%GetNext(.idx, .alert) {
        set msg = alert.annotations.description
        if alert.labels.severity = "critical" {
            set severity = 2
        } else {
            set severity = 1
        }
        
        do ##class(%SYS.System).WriteToConsoleLog(msg, 1, severity)
    }
    quit $$$OK
}

}
