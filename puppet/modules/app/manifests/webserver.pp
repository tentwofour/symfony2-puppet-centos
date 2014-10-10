class app::webserver {
  # Configure apache
  class apache::params {
    $user  = 'vagrant'
    $group = 'vagrant'
  }

  # Install apache
  class { 'apache': }

  # Ensure nginx is not present
  package { "nginx":
    ensure => purged,
  }

  # Ensure we have a vhost config
  file {"/etc/httpd/conf.d/$vhost.conf":
    ensure => present,
    content => template("/vagrant/vagrant/puppet/modules/app/files/etc/apache2/conf.d/app_vhost.conf"),
    require => Package["httpd"],
    notify => Service["httpd"],
  }

  # PHP session dir needs to be writeable by the new webserver user (vagrant)
  file { "/var/lib/php/session" :
    owner  => "root",
    group  => "vagrant",
    mode   => 0770,
    require => Package["php"],
  }
}
