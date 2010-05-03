xquery version "1.0-ml";


import module namespace alert = "http://marklogic.com/xdmp/alert" at "/MarkLogic/alert.xqy";

let $rule := alert:make-rule(
"simple",
"markmessage rule",
0, 
cts:word-query("hello world"),
"newalertaction",
<alert:options/> )
return
alert:rule-insert("markmessage-alerts", $rule)