Exec { path => ['/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'], logoutput => true }

$webserverService = $webserver ? {
    apache => 'httpd',
    default => 'httpd'
}

include app::php
include app::webserver
include app::database
include app::frontend-dev-tools
include app::tools
include app::symfony2

host { 'localhost':
    ip => '127.0.0.1',
    host_aliases => ["localhost.localdomain",
                     "localhost4", "localhost4.localdomain4", "$vhost.dev"],
    notify => Service[$webserverService]
}



