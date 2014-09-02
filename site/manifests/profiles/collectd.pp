class site::profiles::collectd {
  notify { "site::profiles::collectd": }
  include ::collectd
  include apt
  include collectd::plugin::write_graphite
}
