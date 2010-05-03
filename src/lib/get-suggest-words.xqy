xquery version '1.0-ml';

import module namespace search = "http://marklogic.com/appservices/search"
    at "/MarkLogic/appservices/search/search.xqy";

declare namespace msg = "http://marklogic.com/markmessage";

let $term := xdmp:get-request-field('q')


return
  cts:element-word-match(xs:QName("msg:message"), fn:concat($term,"*"), 
    ('ascending', 'case-insensitive','collation=http://marklogic.com/collation/codepoint'))

