# = Class: roundcube
#
# This is the main roundcube class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, roundcube class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $roundcube_myclass
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $roundcube_absent
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# Default class params - As defined in roundcube::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of roundcube package
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include roundcube"
# - Call roundcube as a parametrized class
#
# See README for details.
#
#
class roundcube (
  $my_class            = params_lookup( 'my_class' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $noops               = params_lookup( 'noops' ),
  $des_key             = params_lookup( 'des_key' ),
  $plugins             = params_lookup( 'plugins' ),
  $plugins_config      = params_lookup( 'plugins_config' ),
  $database_db         = params_lookup( 'database_db' ),
  $manage_database     = params_lookup( 'manage_database' ),
  $database_backend    = params_lookup( 'database_backend' ),
  $database_user       = params_lookup( 'database_user' ),
  $database_password   = params_lookup( 'database_password' ),
  $package             = params_lookup( 'package' )
  ) inherits roundcube::params {

  $bool_absent=any2bool($absent)
  $bool_noops=any2bool($noops)
  $bool_manage_database=any2bool($manage_database)

  ### Definition of some variables used in the module
  $manage_package = $roundcube::bool_absent ? {
    true  => 'absent',
    false => $roundcube::version,
  }

  $real_manage_database = $roundcube::bool_manage_database ? {
    true  => File['roundcube_database_preseed'],
    false => unset,
  }

  $array_plugins = is_array($roundcube::plugins) ? {
    false     => $roundcube::plugins ? {
      ''      => [],
      default => [$roundcube::plugins],
    },
    default   => $roundcube::plugins,
  }

  $array_plugins_config = is_array($roundcube::plugins_config) ? {
    false     => $roundcube::plugins_config ? {
      ''      => [],
      default => [$roundcube::plugins_config],
    },
    default   => $roundcube::plugins_config,
  }

  if $roundcube::manage_database {
    include roundcube::database
  }

  ### Managed resources
  package { $roundcube::package:
    ensure  => $roundcube::manage_package,
    require => $real_manage_database,
    noop    => $roundcube::bool_noops,
  }

  file { 'roundcube_config':
    ensure => present,
    path    => '/etc/roundcube/config.inc.php',
    content => template('roundcube/config.inc.php.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'www-data',
    require => $real_manage_database,
  }

  file { $array_plugins_config:
    ensure  => present,
    path    => "/etc/roundcube/plugins/${title}/config.inc.php",
    source  => "puppet:///modules/roundcube/${title}.config.inc.php",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => File['roundcube_config'],
  }

  ### Include custom class if $my_class is set
  if $roundcube::my_class {
    include $roundcube::my_class
  }

}
