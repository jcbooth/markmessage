xquery version "1.0-ml";

import module namespace search = "http://marklogic.com/appservices/search"
    at "/MarkLogic/appservices/search/search.xqy";

let $term := xdmp:get-request-field('q')    

let $options := 
<search:options xmlns="http://marklogic.com/appservices/search">
 <default-suggestion-source>
	 <range collation="http://marklogic.com/collation/codepoint" 
          type="xs:string" facet="false">
         <element ns="http://marklogic.com/markmessage/user" 
               name="username"/>
   </range>
 </default-suggestion-source>
</search:options>

let $results :=
  search:suggest($term, $options)
for $result in $results
return
  fn:replace($result, '"', '')