xquery version "1.0-ml";

declare namespace local = "local";
declare namespace alert = "http://marklogic.com/xdmp/alert";

declare variable $alert:config-uri as xs:string external;
declare variable $alert:doc as node() external;
declare variable $alert:rule as element(alert:rule) external;
declare variable $alert:action as element(alert:action) external;

let $new-alert :=
  <alert>
    <alert-doc-uri>{xdmp:node-uri($alert:doc)}</alert-doc-uri>
  </alert>

return
    xdmp:document-insert(fn:concat("/alerts/alert-", $alert:doc), $new-alert, (), ("alerts-coll"))

  

  