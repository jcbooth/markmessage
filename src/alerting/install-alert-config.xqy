xquery version "1.0-ml";

import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";

declare function local:setup-alert-config() {
let $config :=
  alert:make-config(
      "markmessage-alerts",
      "markmessage Alerts",
      "markmessage alerts configuration.",
      <alert:options/>)
return alert:config-insert($config)
};

let $_ := local:setup-alert-config()
return
<status>Alerting config is now installed!</status>