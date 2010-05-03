xquery version "1.0-ml";
  import module namespace alert = "http://marklogic.com/xdmp/alert" 
          at "/MarkLogic/alert.xqy";
            
  let $action := 
    alert:make-action(
      "newalertaction",
      "log alerts to ErrorLog.txt", 
      xdmp:modules-database(),  
      xdmp:modules-root(), 
      "/alerting/new-alert-action.xqy", 
      <alert:options/>)
  let $install := alert:action-insert("markmessage-alerts", $action)

  return
  <status>
    <actions>Alert actions installed</actions>
    <rules>Rules installed</rules>
  </status>