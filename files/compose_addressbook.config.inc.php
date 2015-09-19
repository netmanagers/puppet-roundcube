<?php
// This file is managed by Puppet. DO NOT EDIT.
//
// which addressbook do we show. this can contain any addressbooks you use, including those set by plugins.
// by default it's the same as the autocomplete_addressbooks setting.

// $rcmail_config['compose_addressbooks'] = array('ldap');
// $rcmail_config['compose_addressbooks'] = array('sql', 'static');
// $rcmail_config['compose_addressbooks'] = array('sql');

// which mode of operation do we use.
//
// full   - show the full addressbook in the popup window. this should work
//          with most users, and is the default
//
// search - popup window starts up empty, and you can search for specific
//          addresses. This is recommended for extremely large addressbooks
//          containing thousands of addresses, and in most LDAP environments.

$rcmail_config['compose_addressbook_mode'] = 'full';

?>
