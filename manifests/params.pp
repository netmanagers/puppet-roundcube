# Class: roundcube::params
#
# This class defines default parameters used by the main module class roundcube
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to roundcube class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class roundcube::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'roundcube',
  }

  $manage_database = true
  $database_backend = 'mysql'
  $database_user = 'roundcube'
  $database_password = fqdn_rand_string(20)
  $database_db = 'roundcube'

  $des_key = fqdn_rand_string(24)
  $plugins = []
  $plugins_config = []

  # General Settings
  $my_class = ''
  $version = 'present'
  $absent = false
  $noops = false

}
