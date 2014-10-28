package {"python-pip": ensure => "installed" }
package {"python-m2crypto": ensure => "installed" }
package {"supervisor": ensure => "installed" }
package {"shadowsocks":
	ensure => "installed",
	provider => "pip"
}
file { "/etc/shadowsocks.json":
	ensure => "present",
	source => "/home/windy/shadowsocks.json"
} 
file { "/etc/supervisor/conf.d/shadowsocks.conf":
	ensure => "present",
	source => "/home/windy/shadowsocks.conf"
}
service { "supervisor": ensure => "running" }
exec {"supervisorctl reload":
	command => "supervisorctl reload",
	path => "/usr/bin",
	logoutput => "true"
}
exec {"supervisorctl status":
        command => "supervisorctl status",
        path => "/usr/bin"
}
