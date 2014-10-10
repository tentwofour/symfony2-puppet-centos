class app::symfony2::npm {
  exec {"npm-install":
    require => Package["nodejs", "npm"],
    command => "/bin/bash -c 'cd /srv/www/vhosts/$vhost/app/Resources && npm install'",
  }
}
