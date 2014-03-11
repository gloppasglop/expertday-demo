class site::profiles::monitoring {
  include ::graphite
  include gdash

  include apache
  include apache::mod::passenger
  $myvhosts = hiera('apache::vhosts', {})
  create_resources('apache::vhost', $myvhosts)

  gdash::category { "Expertday": }

  gdash::dashboard { "OS_Metrics":
        description => "OS Metrics",
        category    => "Expertday",
        require     => Gdash::Category["Expertday"],
  }

  gdash::dashboard { "Web_Server_Metrics":
        description => "Web Server Metrics",
        category    => "Expertday",
        require     => Gdash::Category["Expertday"],
  }

  Gdash::Graph <<||>>
  Gdash::Field <<||>>

}
