xquery version "1.0-ml";

import module namespace msg-view = "http://marklogic.com/markmessage/msg-view-lib" at "../lib/msg-view-lib.xqy";
import module namespace msg-lib = "http://marklogic.com/markmessage/msg-lib" at "../lib/msg-lib.xqy";

declare namespace msg = "http://marklogic.com/markmessage";

xdmp:set-response-content-type("application/xml"),

let $search-term := xdmp:get-request-field("q")
  
let $results := 
  if ($search-term) then 
    msg-lib:search-msgs($search-term) 
  else ()
  
return $results