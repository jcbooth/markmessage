xquery version "1.0-ml";

import module namespace msg-view = "http://marklogic.com/markmessage/msg-view-lib" at "lib/msg-view-lib.xqy";
import module namespace msg-lib = "http://marklogic.com/markmessage/msg-lib" at "lib/msg-lib.xqy";

declare namespace msg = "http://marklogic.com/markmessage";

xdmp:set-response-content-type("text/html"),
   
<html>
<head>
<title>markmessage</title>
<script type="text/javascript" src="js/jquery.js">*</script>
<script type="text/javascript" src="js/jquery-ui-1.8.custom.min.js">*</script>
<script type="text/javascript" src="js/jquery.corners.js">*</script>
<script type="text/javascript" src="js/jquery.autocomplete.js">*</script>
<script type="text/javascript" src="js/jquery.bgiframe.min.js">*</script>
<script type="text/javascript">var SERVER_URL = "http://localhost:7777";</script>
<script type="text/javascript" src="js/global.js">*</script>

<link rel="stylesheet" href="styles/main.css" />
<link rel="stylesheet" href="styles/jquery.autocomplete.css" />
<link type="text/css" href="styles/blitzer/jquery-ui-1.8.custom.css" rel="stylesheet" />	

</head>
<body>

<div id="main">	
<div id="padding">
<div class='rounded' id="mainContent">
<a href="/"><img class="logo" src="images/markmessage1.png"/></a>
<a id="logout" href="javascript:void(0)">Logout</a>

<div id="messages">
{
msg-view:messages-view()
}
<input type="hidden" id="loginuser" value={xdmp:get-session-field("loginname")}/>

</div>
{msg-view:registration-view()}
</div>
</div>
</div>
</body>
</html>