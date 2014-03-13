class site::profiles::puppet::master {

  anchor { '::site::profiles::puppet::master': }

  Class {
    require => Anchor['::site::profiles::puppet::master']
  }

  class { '::puppet::server':
    modulepath         => ['$confdir/environments/$environment/modules', '$confdir/environments/$environment/'],
    manifest           => '$confdir/environments/$environment/site/manifests/site.pp',
    servertype         => 'passenger',
    reports            => 'puppetdb',
    servername         => $::fqdn,
    config_version_cmd => false,
    monitor_server     => false,
    backup_server      => false,
    reporturl          => '',
    ca                 => true,
    parser             => 'future',
  } ->
  class { 'puppetdb': } ->
  class { 'puppetdb::master::config': }

}
