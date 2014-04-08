expertday-demo
==============

# Security groups

expertday-puppetmaster
expertday-graphite
expertday-ssh

# Install Puppet Master

Linux Ubuntu 12.04 64-bit

    wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
    dpkg -i puppetlabs-release-precise.deb 

    sudo apt-get update

    apt-get install -y puppet git
    apt-get install -y rubygems
    gem install r10k
    gem install deep_merge

## Edit /etc/r10k.yaml

    ---
    :cachedir: /var/cache/r10k
    :sources:
      :local:
        remote: https://github.com/gloppasglop/expertday-demo.git
        basedir: /etc/puppet/environments

Install modules

    r10k deploy environment -p --verbose

Configure Hiera


    rm /etc/hiera.yaml

Edit /etc/puppet/hiera.yaml

    ---
    :backends:
      - yaml
    
    :hierarchy:
      - nodes/%{::fqdn}
      - "common"
    
    :yaml:
      :datadir: /etc/puppet/hiera
          
    :merge_behavior: deeper

Link

   ln -s /etc/puppet/hiera.yaml /etc/hiera.yaml

    mkdir /etc/puppet/hiera
    mkdir /etc/puppet/hiera/nodes

Edit /etc/puppet/hiera/common.yaml

    puppet::agent::server: puppet.example.com
    puppet:server::dns_alt_names: puppet.example.com
    puppetdb::ssl_listen_address: puppet.gloppasglop.com

    #collectd::plugin::write_graphite::graphitehost: 192.168.4.140
    #collectd::version: latest
    #gdash::graphite_host: http://192.168.4.140


Configure puppet master:

     puppet apply --certname=puppet.gloppasglop.com --modulepath=/etc/puppet/environments/production:/etc/puppet/environments/production/modules -e 'include site::profiles::puppet::master'

AGENT

    #cloud-config
    manage_etc_hosts: True
    fqdn: monitoring.expertday.demo


    wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
    dpkg -i puppetlabs-release-precise.deb 

    sudo apt-get update

    apt-get install -y puppet


    collectd::plugin::write_graphite::graphitehost: monitoring.expertday.demo
    gdash::graphite_host: http://moniroring.expertday.demo

    classes:
       - site::profiles::monitoring

    puppet agent -t --server puppet.expertday.demo --certname monitoring.expertday.demo


On master

    puppet cert list
    puppet cert sign <certname>


Classify nodes:



