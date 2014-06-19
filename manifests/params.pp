class chrony::params {
  $package_ensure = 'present'
  $service_enable = true
  $service_ensure = 'running'
  $service_manage = true
  $chrony_password = 'xyzzy'
  $queryhosts = undef

  $config_keys_template = 'chrony/chrony.keys.erb'
  $config_template = 'chrony/chrony.conf.erb'

  case $::osfamily {
    'Archlinux': {
      $config = '/etc/chrony.conf'
      $config_keys = '/etc/chrony.keys'
      $package_name = ['chrony']
      $service_name = 'chrony'
      $service_hasstatus = true
      $servers = ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org',]
      $whitelist = []
      $driftfile = '/etc/chrony.drift'
    }
    'RedHat': {
      $config = '/etc/chrony.conf'
      $config_keys = '/etc/chrony.keys'
      $package_name = ['chrony']
      $service_name = 'chronyd'
      $service_hasstatus = true
      $servers = ['0.fedora.pool.ntp.org', '1.fedora.pool.ntp.org', '2.fedora.pool.ntp.org', '3.fedora.pool.ntp.org']
      $whitelist = []
      $driftfile = '/var/lib/chrony/drift'
    }
    'Debian': {
      $config = '/etc/chrony/chrony.conf'
      $config_keys = '/etc/chrony/chrony.keys'
      $package_name = ['chrony']
      $service_name = 'chrony'
      $service_hasstatus = false
      $servers = ['0.debian.pool.ntp.org', '1.debian.pool.ntp.org', '2.debian.pool.ntp.org', '3.debian.pool.ntp.org']
      $chrony_options = {
        'whitelist'     => ['10/8', '192.168/16', '172.16/12'],
        'driftfile'     => '/var/lib/chrony/chrony.drift',
        'commandkey'    => '1',
        'dumpdir'       => '/var/lib/chrony',
        'dumponexit'    => '',
        'local stratum' => '10',
        'logchange'     => '0.5',
        'logdir'        => '/var/log/chrony',
        'rtconutc'      => '',
        'maxupdateskew' => '100.0',
        'log'           => 'tracking measurements statistics'
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
