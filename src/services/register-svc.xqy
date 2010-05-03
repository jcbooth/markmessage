xquery version "1.0-ml";

import module namespace user-lib = "http://marklogic.com/markmessage/user-lib" at "../lib/user-lib.xqy";
import module namespace msg-view = "http://marklogic.com/markmessage/msg-view-lib" at "../lib/msg-view-lib.xqy";

declare namespace msg = "http://marklogic.com/markmessage";

xdmp:set-response-content-type("text/html"),

let $fullname := xdmp:get-request-field("fullname")
let $loginname := xdmp:get-request-field("loginname")
let $password := xdmp:get-request-field("password")

let $_ := xdmp:set-session-field("loginname", $loginname)
let $_ := user-lib:create-user($fullname, $loginname, $password)

return msg-view:messages-view()

	

