## 2.6.0 - 2015-02-18

### Features

Data bag name and item attributes, enabling control over data bags.

## 2.5.0 - 2015-01-29

### Fixes

Sensu directory mode attributes have been moved out of the Linux platform
attributes, allowing Windows nodes to converge.

Sensu service specific RabbitMQ credentials are now only managed if they
have been configured.

### Features

The `random_password` helper has been updated to ensure a certain level of
complexity, meeting Windows server 2012 user password requirements.

API stash LWRP and silencing definitions now support Sensu API stack
expiration (in seconds).

A copy of the Sensu client certificate and key are now stored on the
RabbitMQ node(s), intended to be used for RabbitMQ Federation. They can be
found in `/etc/rabbitmq/ssl/client/`.

## 2.4.0 - 2015-01-23

### Fixes

Ensure RabbitMQ verifies peer certificates.

Runit runsvdir is now managed idempotently.

Use esl-erlang on Ubuntu 12.04 and previous releases to address the poodle
exploit.

Updated ServerSpec tests to work with v2.

### Features

Chef-Vault support for encrypted data bags.

Sensu configuration directory mode attribute.

Sensu service config data bag item support.

RabbitMQ user ACL (permissions) support, allowing Sensu clients to use a
separate RabbitMQ user with different permissions than Sensu servers etc.

## 2.3.0 - 2014-12-18

### Fixes

Reordered RabbitMQ attribute overrides and recipe includes.

Fixed Windows sensu-client service install resource gate.

### Features

Sensu Enterprise recipes, install and service.

Sanitize helper works with delayed eval values.

YUM allow downgrade for the Sensu package.

Sensu user & group attributes.

### Other

Bumped the default version of Sensu to 0.16.0-1.

ChefSpec matchers.

## 2.2.0 - 2014-10-23

### Features

Dropped `content` data type requirements for the Sensu configuration
snippet LWRP, `sensu_snippet`, as it may be a string or array etc.

## 2.1.0 - 2014-10-03

### Non-backwards compatible changes

The Sensu `amqp` handler type is now `transport`, and has the
configuration definition attribute of `pipe` instead of
`exchange`.

### Fixes

Including the `redisio::default` recipe in the redis recipe, in order to
support all current versions of the cookbook.

### Other

Bumped the default version of Sensu to 0.14.0-1.

## 2.0.0 - 2014-07-25

### Non-backwards compatible changes

Removed the Sensu Dashboard service recipe, `dashboard_service`, and
associated cookbook attributes, as the dashboard is no longer part of
Sensu core.

### Fixes

Don't create the `sensu` user with a random password on Windows, if it
already exists.

### Features

Added Sensu extension directory to Windows service configuration.

Windows package options and DISM source cookbook attributes.

Added the `sensu_asset` and `sensu_plugin` LWRPs for fetching/installing
Sensu plugins etc.

### Other

Bumped the default version of Sensu to 0.13.0-1.

Cleaned up Linux package installation recipe.

## 1.0.0 - 2014-04-23

### Fixes

Windows installation fixes/improvements.

### Features

Random password generator helper.

Support for Amazon Linux.

Cookbook attribute for `admin_user`, defaulting to "root" for Linux,
"Administrator" for Windows. This allows recipes to be used on both
platforms.

## 0.8.0 - 2014-01-02

### Features

Cookbook attributes for Sensu repository URLs.

Validate Sensu client and check names with LWRPs.

Support for Sensu client keepalive configuration.

Support for Sensu aggregate check configuration.

## 0.7.1 - 2013-12-19

### Other

Bumped the default version of Sensu to 0.12.3-1.

## 0.7.0 - 2013-12-19

### Fixes

Sensu LWRPs now properly set updated_by_last_action().

The Yum cookbook >= 3.0 is now supported, and `gpgcheck` is set to false
when the resource attribute is available.

### Features

Embedded Runit support for Sensu services. The `init_style` defaults to
"sysv", but can be changed to "runit". The `sensu_service` LWRP is used in
service recipes, eg. `sensu::server_service`.

Data bag item helper, supported plain-text and encrypted Sensu data bag
items.

Sensu configuration through attributes is now merged with Sensu data bag
items, supporting encrypted secrets.

### Other

Bumped the default version of Sensu to 0.12.2-1.

Updated tests to use ServerSpec, using a wrapper cookbook called
`sensu-test`.

## 0.6.2 - 2013-10-28

### Other

Bumped the default version of Sensu to 0.12.0-1.

## 0.6.1 - 2013-10-26

### Other

Bumped the default version of Sensu to 0.11.3-1.

Updated example Vagrantfile to use Ubuntu 13.04.


## 0.6.0 - 2013-10-02

### Non-backwards compatible changes

Redis recipe, switched to redisio cookbook. The cookbook is available
on the OpsCode community site & has better platform/release support.