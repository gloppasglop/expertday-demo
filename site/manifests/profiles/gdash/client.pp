class site::profiles::gdash::client {
  notify { "site::profile::gdash::client": }
  #include gdash

#   #gdash::category { "gdash": }
#
#    gdash::dashboard { "gdash":
#        name        => "GDash",
#        description => "GDash Server",
#        category    => "gdash",
#        require     => Gdash::Category["gdash"],
#    }

   $graphite_fqdn = inline_template( "<%= @fqdn.gsub('.','_')  %>" )

   @@gdash::graph { "expertday_os_metric_load_${graphite_fqdn}":
        name        => "Load Average ${graphite_fqdn}",
        area        => "none",
        vtitle      => "Load",
        description => "Load Average",
        dashboard   => "OS_Metrics",
        category    => "Expertday",
        require     => Gdash::Dashboard["OS_Metrics"],
    }

   @@gdash::field { "${graphite_fqdn}_load_shortterm":
        field_name  => "Load Average Short",
        scale       => 1,
        graph       => "expertday_os_metric_load_${graphite_fqdn}",
        color       => "red",
        alias       => "Short Term (1 minute) ${hostname}",
        data        => "collectd.$graphite_fqdn.load.load.shortterm",
        category    => "Expertday",
        dashboard   => "OS_Metrics",
    }


}
