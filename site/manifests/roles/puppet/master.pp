class site::roles::puppet::master {
<<<<<<< HEAD

  anchor { '::site::roles::puppet::master': }

  Class {
    require => Anchor['::site::roles::puppet::master']
  }

  class { '::puppet::server':
    modulepath         => ['$confdir/modules'],
    manifest           => '/etc/puppet/manifests/site.pp',
    servertype         => 'passenger',
    reports            => 'puppetdb',
    servername         => $::fqdn,
    config_version_cmd => false,
    monitor_server     => false,
    backup_server      => false,
    reporturl          => '',
  } ->
  class { '::puppet::agent':
    server        => hiera('puppet_server'),
    method        => 'service',
    manage_repos  => false,
  } ->

  class { 'puppetdb': } ->
  class { 'puppetdb::master::config': }

=======
  include site::profiles::puppet::master
  include site::profiles::collectd
  include site::profiles::gdash::client
>>>>>>> production
}
