This is the readme for the markmessage application. This is a demo app to show some usage of XQuery with MarkLogic Server. 
The fictious app is markmessage.com, a bare-bones Twitter-like web application. Requires MarkLogic Server 4.1. To use the 
alerting capability, you'll need to select that option with the trial license; alerting is not available with the community
license.

The following is a brief description of the setup of the application. For detailed reference to MarkLogic Server installation
and configuration, please reference the documentation at http://developer.marklogic.com/docs. Namely, the Administrators Guide
 for configuring databases, http servers and indexes. And the Search Developer's Guide. All of the Alerting capability is covered in chapter 10 of the Search Developer's Guide.



MarkLogic Setup
****************

Setup a database named 'markmessage' (no quotes)
 - it will prompt for a forest, create a 'markmessage-1' forest
   and attach to the db.

Setup an HTTP server (under App Servers) naming it 'markmessage' and select
the markmessage database. Point to root where to the root of the 'src' directory of the
downloaded source. If it's in 'C:\markmessage\src', then that will be your root.

Under the markmessage database, select the following options (outside of the defaults):

- fast reverse searches - true
- trailing wildcard searches - true

Word Lexicons:

- Add the 'http://marklogic.com/collation/codepoint' lexicon


Range Indexes:

- Add the following range indexes:

  ******************************************************
  type: string
  namespace uri: http://marklogic.com/markmessage/user
  localname: username
  collation: http://marklogic.com/collation/codepoint (this is unicode codepoint)

  ******************************************************
  type: dateTime
  namespace uri: http://marklogic.com/markmessage
  localname: datetime
 
  ******************************************************
  type: string
  namespace uri: http://marklogic.com/markmessage
  localname: username, markmessage
  collation: http://marklogic.com/collation/codepoint (this is unicode codepoint)



Element Word Lexicons:

- Add the following element word lexicon:

  namespace uri: http://marklogic.com/markmessage
  localname: message
  codepoint: http://marklogic.com/collation/codepoint


After the above is configured. You'll need to configure the alerts. Perform the following steps:

- Install CPF (Content Processing Framework), creating a domain of 'Default markmessage'. Ensure that the
  document scope is collection and make the uri 'messages'.

- Attach the Alerting and Status Change Handling pipelines to the CPF domain just created.

- After that is completed, run the following in CQ to configure the alerts. Run each section of code separately between
the ******** lines:

***********************************************************************************************

xquery version "1.0-ml";

import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";

declare function local:setup-alert-config() {
let $config :=
  alert:make-config(
      "markmessage-alerts",
      "markmessage Alerts",
      "markmessage alerts configuration.",
      <alert:options/>)
return alert:config-insert($config)
};

let $_ := local:setup-alert-config()
return
<status>Alerting config is now installed!</status>

***********************************************************************************************

xquery version "1.0-ml";
import module namespace alert = "http://marklogic.com/xdmp/alert"
at "/MarkLogic/alert.xqy";
import module "http://marklogic.com/xdmp/triggers" at "/MarkLogic/triggers.xqy";

declare namespace admin="http://marklogic.com/xdmp/admin";
declare namespace trgr="http://marklogic.com/xdmp/triggers";


let $config := alert:config-get('markmessage-alerts')
let $config := alert:config-set-cpf-domain-names($config, 'Default markmessage')
return alert:config-insert($config)


***********************************************************************************************

xquery version "1.0-ml";
import module namespace alert = "http://marklogic.com/xdmp/alert"
at "/MarkLogic/alert.xqy";
import module "http://marklogic.com/xdmp/triggers" at "/MarkLogic/triggers.xqy";

declare namespace admin="http://marklogic.com/xdmp/admin";
declare namespace trgr="http://marklogic.com/xdmp/triggers";

  let $uri := 'markmessage-alerts'
  let $trigger-ids :=
    alert:create-triggers(
      $uri,
      trgr:trigger-data-event(
        trgr:collection-scope('messages'),
        trgr:document-content('create'),
        trgr:pre-commit()))
  let $config := alert:config-get($uri)
  let $config := alert:config-set-trigger-ids($config, $trigger-ids)
  return alert:config-insert($config)


***********************************************************************************************

xquery version "1.0-ml";
  import module namespace alert = "http://marklogic.com/xdmp/alert" 
          at "/MarkLogic/alert.xqy";
            
  let $action := 
    alert:make-action(
      "newalertaction",
      "log alerts to ErrorLog.txt", 
      xdmp:modules-database(),  
      xdmp:modules-root(), 
      "/alerting/new-alert-action.xqy", 
      <alert:options/>)
  let $install := alert:action-insert("markmessage-alerts", $action)

  return
  <status>
    <actions>Alert actions installed</actions>
    <rules>Rules installed</rules>
  </status>


***********************************************************************************************


After the alerts are configured, you should be able to go into markmessage, create an account and use the application. Since 
this is a demo app, I currently just open up another browser window to create a message with same word that I'm searching on. Doing
so, should create an alert, showing up in the UI.

