class chrony::params {
  $package_ensure = 'present'
  $service_enable = true
  $service_ensure = 'running'
  $service_manage = true
  $chrony_password = 'xyzzy'
  $queryhosts = undef

  $servers = ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org',]
  $config_keys_template = 'chrony/chrony.keys.erb'

  case $::osfamily {
    'Archlinux' : {
      $config = '/etc/chrony.conf'
      $config_template = 'chrony/chrony.conf.archlinux.erb'
      $config_keys = '/etc/chrony.keys'
      $package_name = ['chrony']
      $service_name = 'chrony'
    }
    'RedHat' : {
      $config = '/etc/chrony.conf'
      $config_template = 'chrony/chrony.conf.redhat.erb'
      $config_keys = '/etc/chrony.keys'
      $package_name = ['chrony']
      $service_name = 'chronyd'
      $servers = ['0.fedora.pool.ntp.org', '1.fedora.pool.ntp.org', '2.fedora.pool.ntp.org', '3.fedora.pool.ntp.org']
    }
    'Debian': {
      $config = '/etc/chrony/chrony.conf'
      $config_template = 'chrony/chrony.conf.redhat.erb'
      $config_keys = '/etc/chrony/chrony.keys'
      $package_name = ['chrony']
      $service_name = 'chrony'
      $servers = ['0.debian.pool.ntp.org', '1.debian.pool.ntp.org', '2.debian.pool.ntp.org', '3.debian.pool.ntp.org']
    }
    default     : {
      fail("The ${module_name} module is not supported
      on an ${::osfamily} based system.")
    }
  }
}
