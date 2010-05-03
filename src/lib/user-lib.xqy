xquery version "1.0-ml";

module namespace user-lib = "http://marklogic.com/markmessage/user-lib";

declare namespace user = "http://marklogic.com/markmessage/user";

declare function user-lib:user-exist($loginname as xs:string, $password as xs:string) as xs:boolean {
  fn:exists(fn:collection("users")/user:user[user:loginname=$loginname][user:password=$password])
};

declare function user-lib:create-user($fullname as xs:string, $loginname as xs:string, $password as xs:string)  {

let $user := 
  <user:user>
      <user:username>{$fullname}</user:username>
      <user:loginname>{$loginname}</user:loginname>
      <user:password>{$password}</user:password>
  </user:user>
return
  user-lib:build-record($user)

};

declare private function user-lib:build-record($user as node()) {
  xdmp:document-insert(fn:concat("/", fn:string($user/user:loginname),".xml"), $user, (), ("users"))
};