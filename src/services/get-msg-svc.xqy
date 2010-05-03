xquery version "1.0-ml";

import module namespace msg-view = "http://marklogic.com/markmessage/msg-view-lib" at "../lib/msg-view-lib.xqy";

declare namespace msg = "http://marklogic.com/markmessage";

xdmp:set-response-content-type("text/html"),

msg-view:get-msgs-view()

