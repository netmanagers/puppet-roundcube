# Class: roundcube::database
#
# This class enforces database resources needed by
# roundcube components
#
# This class is not to be called individually
# and manages the database using dbconfig-common in Debian.
# Not tested nor written for anything else yet :/
#
class roundcube::database {

  include roundcube

  ### Managed resources
  package { 'roundcube-database':
    ensure  => $roundcube::manage_package,
    name    => "roundcube-${roundcube::database_backend}",
    noop    => $roundcube::noops,
    require => Package['roundcube'],
  }

  $real_db_password = $roundcube::database_password ? {
    ''      => fqdn_rand(100000000000),
    default => $roundcube::database_password,
  }

  # DBcommon file, Debian specific
  file { 'dbcommon_roundcube':
    ensure => present,
    path    => '/etc/dbconfig-common/roundcube.conf',
    content => template('roundcube/database-debian.conf.erb'),
    mode    => '0600',
    require => Package['roundcube-database'],
    notify  => Exec['reconfigure-roundcube'],
  }

  # Run reconfigure
  exec { 'reconfigure-roundcube':
    path        => '/usr/sbin:/usr/bin:/sbin:/bin',
    refreshonly => true,
    command     => 'dpkg-reconfigure -f noninteractive roundcube-core',
  }
}
