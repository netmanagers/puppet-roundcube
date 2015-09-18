# Puppet module: roundcube

This is a Puppet module for roundcube
It provides only package installation and management

Based on Example42 layouts by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-roundcube

Released under the terms of Apache 2 License.

This module requires the presence of Example42 Puppi module in your modulepath.


## USAGE - Basic management

* Install roundcube with default settings

        class { 'roundcube': }

* Install a specific version of roundcube package

        class { 'roundcube':
          version => '1.0.1',
        }

* Remove roundcube resources

        class { 'roundcube':
          absent => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'roundcube':
          noops => true
        }

* Automatically include a custom subclass

        class { 'roundcube':
          my_class => 'example42::my_roundcube',
        }


## TESTING
[![Build Status](https://travis-ci.org/example42/puppet-roundcube.png?branch=master)](https://travis-ci.org/example42/puppet-roundcube)
