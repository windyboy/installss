$dir="home"

package {"python-pip": ensure => "installed" }
package {"python-m2crypto": ensure => "installed" }
package {"supervisor": ensure => "installed" }
package {"shadowsocks":
	ensure => "installed",
	provider => "pip",
    require => Package["supervisor"]
}
service {"supervisor":
    ensure => "running",
    require => Package["supervisor"]
}
file { "/etc/shadowsocks.json":
	ensure => "present",
	source => "$dir/shadowsocks.json",
} 
file { "/etc/supervisor/conf.d/shadowsocks.conf":
	ensure => "present",
	source => "$dir/shadowsocks.conf",
}

exec {"supervisorctl reload":
	command => "/usr/bin/supervisorctl reload",
	logoutput => "true",
    require => Service["supervisor"]
}
