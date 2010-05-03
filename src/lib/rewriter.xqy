xquery version "1.0-ml";

let $url := xdmp:get-request-url()

return 
  if (fn:matches($url,"/messages")) then
    fn:replace($url, "^/messages/([a-zA-Z0-9_-]+)$", "/services/get-external-msg-svc.xqy?username=$1")
  else if (fn:matches($url,"/search")) then
    fn:replace($url, "^/search/term=([a-zA-Z0-9_-]+)$", "/services/search-external-msg-svc.xqy?q=$1")    
  else if (fn:matches($url,"/")) then
    fn:replace($url, "^/$", "/main.xqy")
  else $url

