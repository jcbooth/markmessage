xquery version "1.0-ml";

import module namespace msg-view = "http://marklogic.com/markmessage/msg-view-lib" at "../lib/msg-view-lib.xqy";
import module namespace msg-lib = "http://marklogic.com/markmessage/msg-lib" at "../lib/msg-lib.xqy";

declare namespace msg = "http://marklogic.com/markmessage";

xdmp:set-response-content-type("text/html"),

let $msg := xdmp:get-request-field("msg")

let $result := 
  if ($msg) then 
    msg-lib:create-msg($msg) 
  else ()
  
return $result

;
  
xquery version "1.0-ml";

import module namespace msg-view = "http://marklogic.com/markmessage/msg-view-lib" at "../lib/msg-view-lib.xqy";
import module namespace msg-lib = "http://marklogic.com/markmessage/msg-lib" at "../lib/msg-lib.xqy";

declare namespace ch = "http://marklogic.com/markmessage";

msg-view:get-msgs-view()

