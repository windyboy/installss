$dir="home"

package {"python-pip": ensure => "installed" }
package {"python-m2crypto": ensure => "installed" }
package {"supervisor": ensure => "installed" }
package {"shadowsocks":
	ensure => "installed",
	provider => "pip"
}
file { "/etc/shadowsocks.json":
	ensure => "present",
	source => "$dir/shadowsocks.json"
} 
file { "/etc/supervisor/conf.d/shadowsocks.conf":
	ensure => "present",
	source => "$dir/shadowsocks.conf",
    require => Package["shadowsocks"],
    notify => Service ["shadowsocks"]
}

service { "supervisor": 
    ensure => "running",
    require Package["shadowsocks"]
}
exec {"supervisorctl update":
	command => "/usr/bin/supervisorctl update",
	logoutput => "true"
}
exec {"supervisorctl reload":
        command => "/usr/bin/supervisorctl reload",
}
