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

  # General Settings
  $my_class = ''
  $version = 'present'
  $absent = false
  $noops = false

}
