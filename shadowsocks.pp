$dir="home"
$supervisor = $operatingsystem ? {
    centos => "supervisord",
    default => "supervisor"
}
package {"python-pip": ensure => "installed" }
package {"python-m2crypto": ensure => "installed" }
package {"supervisor": ensure => "installed" }
package {"shadowsocks":
	ensure => "installed",
	provider => "pip",
    require => Package["supervisor"]
}
file {"/etc/supervisor/conf.d":
    ensure => "directory",
    require => Package["supervisor"]
}
service {$supervisor:
    ensure => "running",
    require => Package["supervisor"]
}
file { "/etc/shadowsocks.json":
	ensure => "present",
	source => "$dir/shadowsocks.json",
}
if $operatingsystem == "centos" {
   file {"/etc/supervisord.conf":
        ensure => "present"
        source => "$dir/supervisord.conf"
   } 
}
file { "/etc/supervisor/conf.d/shadowsocks.conf":
	ensure => "present",
	source => "$dir/shadowsocks.conf",
    require => Package["supervisor"]
}

exec {"supervisorctl reload":
	command => "/usr/bin/supervisorctl reload",
	logoutput => "true",
    require => Service["supervisor"]
}
