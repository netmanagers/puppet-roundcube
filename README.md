# Puppet module: roundcube

## [Maintainer wanted](https://github.com/netmanagers/puppet-roundcube/issues/new)

**WARNING WARNING WARNING**

[puppet-roundcube](https://github.com/netmanagers/puppet-roundcube) is not currently being maintained, 
and may have unresolved issues or not be up-to-date. 

I'm still using it on a daily basis (with Puppet 3.8.5) and fixing issues I find
while using it. But sadly, I don't have the time required to actively add new features,
fix issues other people report or port it to Puppet 4.x.

If you would like to maintain this module,
please create an issue at: https://github.com/netmanagers/puppet-roundcube/issues
offering yourself.

## Getting started

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
