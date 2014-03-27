class site::profiles::webserver {
  
  include nginx

  class { 'collectd::plugin::nginx':
    url      => "http://${::hostname}:80/nginx_status",
  }

  Class['nginx']->Class['collectd::plugin::nginx']

   $tmp_fqdn = inline_template( "<%= @fqdn.gsub('.','_')  %>" )

   @@gdash::graph { "expertday_web_metric_requests_${tmp_fqdn}":
        graph_title => "HTTP reqs/s ${hostname}",
        area        => "none",
        vtitle      => "HTTP Requests",
        description => "HTTP Requests",
        dashboard   => "Web_Metrics",
        category    => "Expertday",
        require     => Gdash::Dashboard["Web_Metrics"],
    }

   @@gdash::field { "${tmp_fqdn}_http_reqs":
        field_name    => "requests/s",
        scale         => 1,
        graph         => "expertday_web_metric_requests_${tmp_fqdn}",
        color         => "red",
        legend_alias  => "Reqs/s",
        data          => "derivative(collectd.${tmp_fqdn}.nginx.nginx_requests)",
        category      => "Expertday",
        dashboard     => "Web_Metrics",
    }
}
