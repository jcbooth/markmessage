xquery version "1.0-ml";

import module namespace msg-view = "http://marklogic.com/markmessage/msg-view-lib" at "../lib/msg-view-lib.xqy";
import module namespace msg-lib = "http://marklogic.com/markmessage/msg-lib" at "../lib/msg-lib.xqy";
import module namespace alert-lib = "http://marklogic.com/alert-lib" at "../lib/alert-lib.xqy";

declare namespace msg = "http://marklogic.com/markmessage";

xdmp:set-response-content-type("text/html"),

let $search-term := xdmp:get-request-field("q")

return alert-lib:create-new-rule($search-term)
	

