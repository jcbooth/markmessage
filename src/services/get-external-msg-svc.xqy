xquery version "1.0-ml";

import module namespace msg-lib = "http://marklogic.com/markmessage/msg-lib" at "../lib/msg-lib.xqy";

declare namespace msg = "http://marklogic.com/markmessage";

xdmp:set-response-content-type("application/xml"),

let $username := xdmp:get-request-field("username")

return
  msg-lib:get-msgs($username)
