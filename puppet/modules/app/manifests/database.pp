class app::database {

    # Installs the MySQL server and MySQL client
    #package { ['mysql-server', 'mysql-client']: ensure => installed, }

    mysql::db { $vhost:
      user     => $vhost,
      password => $vhost,
    }

  class { "mysql": }

  class { "mysql::server":
    config_hash => {
      "root_password" => $vhost,
      "etc_root_password" => false
    }
  }

  Mysql::Db {
    require => Class['mysql::server', 'mysql::config']
  }
}

