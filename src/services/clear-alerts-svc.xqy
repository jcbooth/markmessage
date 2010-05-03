xquery version "1.0-ml";

import module namespace alert-lib = "http://marklogic.com/alert-lib" at "../lib/alert-lib.xqy";

declare namespace msg = "http://marklogic.com/markmessage";

let $clear-rules := xdmp:get-request-field("clear-rules")

return
  alert-lib:baseline(xs:boolean($clear-rules))
