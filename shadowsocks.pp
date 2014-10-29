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
    enable  => "true"
}
file { "/etc/shadowsocks.json":
	ensure => "present",
	source => "$dir/shadowsocks.json",
    notify => Service ["supervisor"]
} 
file { "/etc/supervisor/conf.d/shadowsocks.conf":
	ensure => "present",
	source => "$dir/shadowsocks.conf",
    require => Package["shadowsocks"]
}

exec {"supervisorctl reload"
	command => "/usr/bin/supervisorctl reload",
	logoutput => "true",
    require => File["/etc/supervisor/conf.d/shadowsocks.conf"],
    notify => Service ["supervisor"]
}
