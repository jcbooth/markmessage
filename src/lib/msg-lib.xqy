xquery version "1.0-ml";

module namespace msg-lib = "http://marklogic.com/markmessage/msg-lib";

declare namespace msg = "http://marklogic.com/markmessage";

declare function msg-lib:get-msgs($username as xs:string?) as node()* {
   
   let $search-coll :=
     if ($username ne "") then   
       fn:collection("messages")[msg:msg/msg:user/msg:username eq $username]
     else
       fn:collection("messages")
   return
   
  (for $msg in $search-coll
   order by 
     xs:dateTime($msg//msg:datetime) descending
   return $msg)[1 to 20]
};

declare function msg-lib:search-msgs($search-term as xs:string) as node()* {
   for $msg in cts:search(fn:collection('messages'), cts:word-query($search-term, ('case-insensitive', 'punctuation-insensitive')))[1 to 20]
   order by 
     xs:dateTime($msg//msg:datetime) descending
   return $msg
};

declare function msg-lib:create-msg($msg as xs:string)  {
  
let $msg := 
  <msg:msg xmlns:msg="http://marklogic.com/markmessage">
    <msg:id>{xdmp:random(100000)}</msg:id>
    <msg:user>
      <msg:username>{xdmp:get-session-field("loginname")}</msg:username>
    </msg:user>
    <msg:message>{$msg}</msg:message>
    <msg:datetime>{fn:current-dateTime()}</msg:datetime>
  </msg:msg>
return
  msg-lib:build-record($msg)

};

declare function msg-lib:build-record($msg as node()) {
  xdmp:document-insert(fn:concat("/", fn:string($msg/msg:id),".xml"), $msg, (), ("messages"))
};