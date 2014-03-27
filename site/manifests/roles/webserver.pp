class site::roles::webserver inherits site::roles::base {
  notify { "site::roles::webserver": }
  include site::profiles::webserver
  include site::profile::monitoring::webserver
}
