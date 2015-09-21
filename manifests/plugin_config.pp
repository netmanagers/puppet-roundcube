# = Define: roundcube::plugin_config
#
# This define adds the config for the plugin that needs it
#
# == Parameters
# plugin name

define roundcube::plugin_config(
  $prefix  = params_lookup( 'prefix' ),
  $options = params_lookup( 'options' ),
) {
  file { $name:
    ensure  => present,
    path    => "/etc/roundcube/plugins/${name}/config.inc.php",
    content => template('roundcube/plugin.config.inc.php.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => File['roundcube_config'],
  }
}
