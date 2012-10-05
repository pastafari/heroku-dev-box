# Forked from the rails-dev-box repository. Thank you
stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { '/usr/bin/apt-get -y update':
    user => 'root'
  }
}

class { 'apt_get_update':
  stage => preinstall
}


class install_postgres {
  class { 'postgresql': }

  class { 'postgresql::server': }

  pg_database { 'heroku_database':
    ensure   => present,
    encoding => 'UTF8',
    require  => Class['postgresql::server']
  }

  pg_user { 'vagrant':
    ensure    => present,
    superuser => true,
    require   => Class['postgresql::server']
  }

  package { 'libpq-dev':
    ensure => installed
  }
}

class { 'install_postgres': }

class install_core_packages {
  if !defined(Package['build-essential']) {
    package { 'build-essential':
      ensure => installed
    }
  }

  if !defined(Package['git-core']) {
    package { 'git-core':
      ensure => installed
    }
  }
}

class { 'install_core_packages': }

# Installs Ruby 1.9.2 MRI. Package is named 1.9.1 for some strange reason. Refer http://www.ruby-lang.org/en/downloads/ for details

class install_ruby {
  package { 'ruby1.9.1':
    ensure => installed
  }

  exec { '/usr/bin/gem install bundler --no-rdoc --no-ri':
    unless  => '/usr/bin/gem list | grep bundler',
    user    => 'root',
    require => Package['ruby1.9.3']
  }
}
class { 'install_ruby': }

class install_nokogiri_dependencies {
  package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
    ensure => installed
  }
}
class { 'install_nokogiri_dependencies': }

# Node.js
class install_execjs_runtime {
  package { 'nodejs':
    ensure => installed
  }
}
class { 'install_execjs_runtime': }
