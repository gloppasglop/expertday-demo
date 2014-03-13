class site::roles::base {
  anchor { '::site::roles::base': }

  Class {
    require => Anchor['::site::roles::base'],
  }

  class { '::ntp': }

  include site::profiles::collectd
  include site::profiles::puppet::agent
  include site::profiles::gdash::client
}
