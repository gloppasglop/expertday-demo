node 'puppet.example.com' {
  class { '::site::roles::base': } ->
  class { '::site::roles::puppet::master': }
}
