xquery version "1.0-ml";

module namespace msg-view = "http://marklogic.com/markmessage/msg-view-lib";

import module namespace msg-lib = "http://marklogic.com/markmessage/msg-lib" at "msg-lib.xqy";

declare namespace msg = "http://marklogic.com/markmessage";


declare function msg-view:get-elapsed-time($date-time as xs:dateTime?) as xs:string? {

let $date-diff := 
      fn:current-dateTime() - $date-time
    
let $result :=
  if (fn:minutes-from-duration($date-diff) ne 0) then
    fn:concat("about ", fn:minutes-from-duration($date-diff), " minute(s) ago...")
  else ()

let $result :=
  if (fn:hours-from-duration($date-diff) ne 0) then
    fn:concat("about ", fn:hours-from-duration($date-diff), " hour(s) ago...")
  else $result

let $result :=
  if (fn:days-from-duration($date-diff) ne 0) then
    fn:concat("about ", fn:days-from-duration($date-diff), " day(s) ago...")
  else $result

return if($result) then $result
       else "about 0 minute(s) ago..."

};

declare function msg-view:get-msgs-view() as element(li)* {
  for $msg in msg-lib:get-msgs("")
  return 
    msg-view:build-msg-view($msg)
};

declare function msg-view:build-msg-view($msg as node()) as element(li)* {
    <li id="result">
      <div class="msg">
        <a class="name" href="javascript:void(0)">{fn:string($msg//msg:user/msg:username)}</a>&nbsp;&nbsp;
        <span class="msg">{fn:string($msg//msg:message)}</span>
        <div class="time">
          <span>{msg-view:get-elapsed-time($msg//msg:datetime)}</span>
        </div>
      </div>
    </li>
};
    
declare function msg-view:get-msgs-view-input($msgs as node()*) as element(li)* {
  for $msg in $msgs
  return 
    <li id="result">
      <div class="msg">
        <a class="name" href="javascript:void(0)">{fn:string($msg//msg:user/msg:username)}</a>&nbsp;&nbsp;
        <span class="msg">{fn:string($msg//msg:message)}</span>
        <div class="time">
          <span>{msg-view:get-elapsed-time($msg//msg:datetime)}</span>
        </div>
      </div>
    </li>
};

declare function msg-view:registration-view() {

<div>
<div class="markbutton" id="loginbox">
  User Name:<br/>
  <input type="text" id="loginname" name="loginname" class="login" value=""/><br/><br/>
  Password:<br/>
  <input type="password" id="password" name="password" class="login" value=""/>
  <div id="loginbuttonbox">
    <a id="login" href="javascript:void(0)">Login</a>
  </div>
</div>
<br/>
<div class="markbutton" id="registerbox">
  <span id="warning">Password don't match. Please re-enter</span><br/><br/>
  Full Name:<br/>
  <input type="text" id="fullname-r" name="fullname" class="login" value=""/><br/><br/>
  User Name:<br/>
  <input type="text" id="loginname-r" name="loginname" class="login" value=""/><br/><br/>
  Password:<br/>
  <input type="password" id="password-r" name="password" class="login" value=""/><br/><br/>
  Confirm Password:<br/>
  <input type="password" id="confirmpassword-r" name="confirmpassword" class="login" value=""/>  
  <div id="loginbuttonbox">
    <a id="registerbutton" href="javascript:void(0)">Register</a>
  </div>
</div>
<br/>


<a id="register" href="javascript:void(0)">Click to Register</a>
</div>
};

declare function msg-view:messages-view() {
<div>
<div class="markbutton" id="searchbox">
<input type="text" name="q" id="search" value=""/>&nbsp;
<a id="searchbutton" href="javascript:void(0)">Search</a>
</div>
  <div class='innerrounded' id="results">
    <div class='innerrounded' id="mybox">
      <div id="counter">140</div>
      <textarea class='innerrounded' id="msgtext">Enter message here...</textarea>&nbsp;
      <div class="markbutton mybutton"><a id="msgbutton" href="javascript:void(0)">Post</a></div>     
    </div>
    <a id="backtomessages" href="javascript:void(0)">Back to messages</a>
   
    <span> 
    <center><div class="msg" id="searchresult-msg">XXX</div></center> 
    <center><div class="msg" id="alert-msg"><span id="alert-count">.</span> more results. <a id="alertlink" href="javascript:void(0)">Click here</a> to view them.</div></center> 
    </span>
    <ul id="msglist">{msg-view:get-msgs-view()}</ul>
    <a id="more-messages" href="main.xqy">More messages...</a>
    <input type="hidden" id="search-term" value=""/>
 
  </div>
  </div>
};
