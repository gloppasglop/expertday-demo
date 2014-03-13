class site::profiles::collectd {
  notify { "site::profiles::collectd": }
  include ::collectd
  include apt
  apt::ppa { 'ppa:kmscherer/collectd': } -> Class['::collectd']
  include collectd::plugin::write_graphite
}
