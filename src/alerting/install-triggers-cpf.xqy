xquery version "1.0-ml";
import module namespace alert = "http://marklogic.com/xdmp/alert"
at "/MarkLogic/alert.xqy";
import module "http://marklogic.com/xdmp/triggers" at "/MarkLogic/triggers.xqy";

declare namespace admin="http://marklogic.com/xdmp/admin";
declare namespace trgr="http://marklogic.com/xdmp/triggers";


(:
  let $config := alert:config-get('markmessage-alerts')
  let $config := alert:config-set-cpf-domain-names($config, 'Default markmessage')
  return alert:config-insert($config)
:)


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