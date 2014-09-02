class site::roles::monitoring inherits site::roles::base {
  notify { "site::roles::monitoring": } 
  include site::profiles::monitoring
} 
