xquery version "1.0-ml";

module namespace alert-lib="http://marklogic.com/alert-lib";

import module namespace alert = "http://marklogic.com/xdmp/alert" at "/MarkLogic/alert.xqy";
                                        
                                        
declare function alert-lib:create-new-rule($word as xs:string) {
     
  let $rule := 
    alert:make-rule("markmessage word",
    		    "markmessage rule",
		     0, 
		     cts:word-query($word),
		    "newalertaction",
		    <alert:options/> )
  return
    alert:rule-insert("markmessage-alerts", $rule)
};

declare function alert-lib:baseline($clear-rules as xs:boolean) {

  let $alerts :=
      xdmp:collection-delete("alerts-coll") 

  let $rules :=
    if($clear-rules = fn:true()) then 
      if (fn:exists(xdmp:directory("markmessage-alerts/rules/") )) then 
        xdmp:directory-delete("markmessage-alerts/rules/")  
      else ()
    else ()
  
  return
    $alerts
};