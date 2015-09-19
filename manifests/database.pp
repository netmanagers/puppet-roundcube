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
  $real_db_password = $roundcube::database_password ? {
    ''      => fqdn_rand(100000000000),
    default => $roundcube::database_password,
  }

  # Debian preseed for roundcube-core
  file { 'roundcube_database_preseed':
    ensure => present,
    path    => '/var/cache/debconf/roundcube-core.seeds',
    content => template('roundcube/rouncube-core.preseed.erb'),
    mode    => '0600',
    notify  => Exec['reconfigure-roundcube'],
  }

  package { 'roundcube-core':
    ensure       => $roundcube::manage_package,
    noop         => $roundcube::noops,
    require      => File['roundcube_database_preseed'],
    responsefile => '/var/cache/debconf/roundcube-core.seeds',
  }

  package { 'roundcube-database':
    ensure  => $roundcube::manage_package,
    name    => "roundcube-${roundcube::database_backend}",
    noop    => $roundcube::noops,
    require => Package['roundcube-core'],
    notify  => Exec['reconfigure-roundcube'],
  }

  # Run reconfigure
  exec { 'reconfigure-roundcube':
    path        => '/usr/sbin:/usr/bin:/sbin:/bin',
    refreshonly => true,
    command     => 'dpkg-reconfigure -f noninteractive roundcube-core',
  }
}
