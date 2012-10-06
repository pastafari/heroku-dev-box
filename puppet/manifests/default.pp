# Forked from the rails-dev-box repository. Thank you
stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { '/usr/bin/apt-get -y update':
    user => 'root',
  }

  package { 'python-software-properties':
    ensure => installed,
  }

  exec {'/usr/bin/add-apt-repository ppa:chris-lea/node.js':
    require => Package['python-software-properties'],
  }
}

class { 'apt_get_update':
  stage => preinstall
}


class install_postgres {
  package { 'postgresql': }

  package { 'postgresql-client': }

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
class install_rubygems {
  exec { 'download-rubygems-tar':
    command => '/usr/bin/wget http://rubyforge.org/frs/download.php/76073/rubygems-1.8.24.tgz',
    cwd => '/tmp',
  }

  exec { 'install-rubygems':
    command => '/bin/tar -xf rubygems-1.8.24.tgz && cd rubygems-1.8.24 && ruby setup.rb',
    cwd => '/tmp',
    require => Exec['download-rubygems-tar'],
  }

  exec {'symlink-gem':
    command => 'ln -sf /opt/vagrant_ruby/bin/gem',
    path => '/bin',
    cwd => '/etc/alternatives',
    require => Exec['install-rubygems'],
  }
}

class {'install_rubygems': }

class install_ruby {
  package { 'ruby1.9.1':
    ensure => installed,
  }

  exec { '/usr/bin/gem install bundler --no-rdoc --no-ri':
    unless  => '/usr/bin/gem list | grep bundler',
    user    => 'root',
    require => [Package['ruby1.9.1'], Class['install_rubygems']],
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

  package { 'npm':
    ensure => installed
  }
}
class { 'install_execjs_runtime': }
