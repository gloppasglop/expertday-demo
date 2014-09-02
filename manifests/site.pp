node 'puppet.example.com' {
  class { '::site::roles::base': } ->
  class { '::site::roles::puppet::master': }
}


node 'b9836319-968f-444c-8906-a5ad104bf90c.localdomain' {
  class { '::site::roles::base': }
}
