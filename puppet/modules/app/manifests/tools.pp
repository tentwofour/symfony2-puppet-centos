class app::tools {
    package {["mlocate",
              "zip",
              "unzip",
              "strace",
              "patch",
              "git"]:
        ensure => present,
    }

    exec {"find-utils-updatedb":
        command => "/usr/bin/updatedb &",
        require => Package["mlocate"],
    }
}