include supervisord
$dir="/tmp/sss"
if $operatingsystem == "centos" {
    $supervisor="supervisord"
    #centos install shadowsocks with nodejs
    include nodejs
    #package {"supervisor": ensure => "installed", provider => "pip" }
    package { 'shadowsocks':
        ensure   => present,
	provider => "npm",
    }
}
else {
    $supervisor="supervisor"
    package {"python-pip": ensure => "installed" }
    package {"m2crypto": ensure => "installed", provider => "pip" }
    #defined in module
    #package {"supervisor": ensure => "installed" }
    package {"shadowsocks":
	    ensure => "installed",
	    provider => "pip",
    }

}
file { "/etc/shadowsocks.json":
	ensure => "present",
	source => "$dir/shadowsocks.json",
}

supervisord::program { 'shadowsocks':
	command => '/usr/bin/ssserver -c /etc/shadowsocks.json',
	autostart => true,
	autorestart => "true",
    require => File['/etc/shadowsocks.json'],
}

