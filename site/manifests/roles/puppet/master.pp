class site::roles::puppet::master {
  include site::profiles::puppet::master
  include site::profiles::collectd
  include site::profiles::gdash::client
}
