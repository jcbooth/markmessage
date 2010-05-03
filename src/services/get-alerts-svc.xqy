xquery version "1.0-ml";

declare function local:get-alerts-count() {
  let $count :=
    xdmp:eval('fn:count(fn:collection("alerts-coll")/alerts/alert)')
  let $result := 
    if($count > 0 )
    then $count
    else (xdmp:sleep(1000), local:get-alerts-count())
  return $result
};

fn:count(fn:collection('alerts-coll'))
