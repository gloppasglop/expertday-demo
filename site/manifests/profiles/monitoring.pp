class site::profiles::monitoring {
  include ::graphite
  include gdash

  include apache
  include apache::mod::passenger
  $myvhosts = hiera('apache::vhosts', {})
  create_resources('apache::vhost', $myvhosts)

   # Create Apache virtual host
    apache::vhost { "gdash.example.com":
        servername      => "gdash.example.com",
        port            => "9292",
        docroot         => "/usr/local/gdash/public",
        error_log_file  => "gdash-error.log",
        access_log_file => "gdash-access.log",
        directories     => [
            {
                path            => "/usr/local/gdash/",
                options         => [ "None" ],
                allow           => "from All",
                allow_override  => [ "None" ],
                order           => "Allow,Deny",
            }
        ]
    }

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
