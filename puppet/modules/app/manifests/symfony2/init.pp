class app::symfony2::init {

    # Install / Update the vendors with composer
    class { 'composer':
        command_name => 'composer',
        target_dir   => '/usr/local/bin'
    }

    include composer

    exec { "composer-install" :
        command     => "/bin/bash -c 'cd /srv/www/vhosts/$vhost && /usr/local/bin/composer install'",
        environment => ["COMPOSER_HOME=/home/vagrant"],
        creates     => "/srv/www/vhosts/$vhost/vendor/symfony",
        require     => [ Package["php-cli"], Package["git"] ],
        timeout     => 0,
        tries       => 10,
    }

    #todo - this should read the apache::params::$user and $group settings
    exec {"set-cache-and-log-permissions":
      require => [Exec["create-symfony-cache-dir"]],
      command => "/bin/bash -c '/usr/bin/setfacl -R -m u:vagrant:rwX -m u:vagrant:rwX /dev/shm/$vhost/cache /dev/shm/$vhost/logs && /usr/bin/setfacl -dR -m u:vagrant:rwX -m u:vagrant:rwX /dev/shm/$vhost/cache /dev/shm/$vhost/logs'",
    }

    exec {"create-symfony-cache-dir":
      command => "/bin/bash -c '/bin/mkdir /dev/shm/$vhost'",
      unless => "/bin/bash -c '[ -d /dev/shm/$vhost ]'"
    }

    # Redundant, if there are composer scripts running
    exec {"clear-symfony-cache":
        require => [Exec["set-cache-and-log-permissions"], Package["php-cli"]],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost && /usr/bin/php app/console cache:clear --env=dev && /usr/bin/php app/console cache:clear --env=prod'",
    }

    # Drop database
    exec {"db-drop":
        require => Package["php-cli"],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost && /usr/bin/php app/console doctrine:schema:drop --force'",
    }

    # Create database
    exec {"db-setup":
        require => [Exec["db-drop"], Package["php-cli"]],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost && /usr/bin/php app/console doctrine:schema:create'",
    }

    # Load fixtures
    exec {"db-default-data":
        require => [Exec["db-setup"], Package["php-cli"]],
        command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost && /usr/bin/php app/console doctrine:fixtures:load -n'",
        onlyif => "/usr/bin/test -n \"$(find /srv/www/vhosts/$vhost/src -type d -name DataFixtures -print -quit)\"",
    }


}
