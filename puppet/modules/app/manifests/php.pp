class app::php {

  require remi

  # Install PHP CLI
  class { 'php::cli': ensure => 'latest' }

  # Install apache PHP module
  class { 'php::mod_php5': }

  # Install all the modules needed
  php::module { [ 'apc', 'mcrypt', 'intl', 'mysql', 'mbstring', 'gd', 'pecl-imagick', 'xml' ]: }

  php::ini { '/etc/php.ini':
    display_errors => 'On',
    memory_limit   => '512M',
    upload_max_filesize => '20M',
    post_max_size => '80M',
    date_timezone => 'America/Regina'
  }


}

