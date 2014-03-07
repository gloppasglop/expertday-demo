class site::roles::puppet::master {

  anchor { '::site::roles::puppet::master': }

  Class {
    require => Anchor['::site::roles::puppet::master']
  }

  class { '::puppet::server':
    modulepath         => ['$confdir/environments/$environment/modules', '$confdir/environments/$environment/'],
    manifest           => '$confdir/environments/$environment/manifests/site.pp',
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

