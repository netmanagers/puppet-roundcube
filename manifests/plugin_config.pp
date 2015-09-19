# = Define: roundcube::plugin_config
#
# This define adds the config for the plugin that needs it
#
# == Parameters
# plugin name

define roundcube::plugin_config() {
  file { $name:
    ensure  => present,
    path    => "/etc/roundcube/plugins/${name}/config.inc.php",
    source  => "puppet:///modules/roundcube/${name}.config.inc.php",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => File['roundcube_config'],
  }
}
