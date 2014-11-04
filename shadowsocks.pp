include supervisord
$dir="/tmp/sss"
if $operatingsystem == "centos" {
    #centos install shadowsocks with nodejs
    $ssspath="/usr/local/node/node-default/bin/ssserver -c /etc/shadowsocks.json"
    package {"python-pip": ensure => "installed" }
    #package {["nodejs", "npm"]: ensure => "installed" }
    include nodejs
    package { 'shadowsocks':
      provider => 'npm',
      require  => Class['nodejs']
    }
    supervisord::program { 'shadowsocks':
        command => "/usr/local/node/node-default/bin/ssserver -c /etc/shadowsocks.json",
        autostart => true,
        autorestart => "true",
        require => [Package['shadowsocks'],File['/etc/shadowsocks.json']],
	environment => { 'PATH' => "/usr/local/node/node-default/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin" },
    }
}
else {
    package {"python-pip": ensure => "installed" }
    package {"m2crypto": ensure => "installed", provider => "pip" }
    #defined in module
    #package {"supervisor": ensure => "installed" }
    package {"shadowsocks":
	    ensure => "installed",
	    provider => "pip",
    }
    supervisord::program { 'shadowsocks':
        command => "/usr/local/bin/ssserver -c /etc/shadowsocks.json",
        autostart => true,
        autorestart => "true",
        require => [Package['shadowsocks'],File['/etc/shadowsocks.json']],
        environment => { 'PATH' => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" },
    }

}
file { "/etc/shadowsocks.json":
	ensure => "present",
	source => "$dir/shadowsocks.json",
}

