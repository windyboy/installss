$dir="home"

package {"python-pip": ensure => "installed" }
package {"python-m2crypto": ensure => "installed" }
package {"supervisor": ensure => "installed" }
package {"shadowsocks":
	ensure => "installed",
	provider => "pip"
}
service { "supervisor": 
    ensure => "running",
    require Package["shadowsocks"]
}
file { "/etc/shadowsocks.json":
	ensure => "present",
	source => "$dir/shadowsocks.json",
    notify => Service ["supervisor"]
} 
file { "/etc/supervisor/conf.d/shadowsocks.conf":
	ensure => "present",
	source => "$dir/shadowsocks.conf",
    require => Package["shadowsocks"],
    notify => Service ["supervisor"]
}

exec {"supervisorctl update":
	command => "/usr/bin/supervisorctl update",
	logoutput => "true",
    require => File["/etc/supervisor/conf.d/shadowsocks.conf"],
    notify => Service ["supervisor"]
}
