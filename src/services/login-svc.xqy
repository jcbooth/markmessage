xquery version "1.0-ml";

import module namespace user-lib = "http://marklogic.com/markmessage/user-lib" at "../lib/user-lib.xqy";

declare namespace user = "http://marklogic.com/markmessage/user";

xdmp:set-response-content-type("text/html"),

let $loginname := xdmp:get-request-field("loginname")
let $password := xdmp:get-request-field("password")

let $result := user-lib:user-exist($loginname, $password)
let $_ := 
  if($result) then
    xdmp:set-session-field("loginname", $loginname)
  else ()
  
return 
  $result
  
	

