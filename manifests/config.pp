class chrony::config inherits chrony {
  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
  }

  file { $config_keys:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0640',
    content => template($config_keys_template),
  }

}
