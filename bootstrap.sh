#!/usr/bin/env bash 

set -e

export DEBIAN_FRONTEND=noninteractive 

INSTALLED="Installed:"

msg() { echo "*" echo "*"
  echo "*****************************************************************"
  echo "*****************************************************************"
  echo "$1"
}

apt() {
  sudo apt-get install -y --force-yes $1
}

apt_3rd_party() {
  # node.js  repo
  if [ ! -f /etc/apt/sources.list.d/nodesource.list ]; then 
    msg "adding node.js repo"
    curl -sL https://deb.nodesource.com/setup | sudo bash -
  fi
}

apt_upgrade() {
  if [ "$[$(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin)]" -ge 3600 ]; then
    msg "APT update"
    sudo apt-get update
    msg "APT dist-upgrade"
    sudo apt-get dist-upgrade -q -y --force-yes 
    INSTALLED+="- apt-upgrade"
  fi
}

apt_core() {
  pkgs="curl git-core screen tmux vim zerofree ntpdate"
  pkgs="$pkgs zlib1g-dev build-essential libssl-dev libreadline-dev"
  pkgs="$pkgs libyaml-dev libxml2-dev libxslt1-dev libffi-dev" 
  pkgs="$pkgs libcurl4-openssl-dev python-software-properties nodejs"
  pkgs="$pkgs imagemagick libmagickwand-dev libgmp-dev libsqlite3-dev sqlite3"
  

  msg "install pkgs"
  apt "$pkgs"
  sudo ntpdate -u pool.ntp.org
}

apt_clean() {
  msg "APT clean"
  sudo apt-get -y autoremove
  sudo apt-get -y clean
  sudo apt-get autoclean -y

  INSTALLED+="- apt-clean"
}

install_postgres() {
  msg "postgresql"
  apt "postgresql libpq-dev postgresql-server-dev-all postgresql-contrib"

  # install pgcrypto module
  #if [[ ! $(sudo -u postgres psql template1 -c '\dx') =~ pgcrypto ]]; then
  #  sudo -u postgres psql template1 -c 'create extension pgcrypto'
  #fi

  # Add rails user with superuser
  msg "Check if rails user allready exists"
  if [[ ! $(sudo -u postgres psql template1 -c '\du') =~ rails ]]; then
    msg "Add rails superuser"
    sudo -u postgres psql template1 -c \
      "create user rails with superuser password 'railspass'"
  fi
  if [[ -d /etc/postgresql/9.1 ]]; then 
    sudo sh -c "echo \"local all postgres  peer\nlocal all all       md5\" \
      > /etc/postgresql/9.1/main/pg_hba.conf" 
  fi
  if [[ -d /etc/postgresql/9.3 ]]; then 
    sudo sh -c "echo \"local all postgres  peer\nlocal all all       md5\" \
      > /etc/postgresql/9.3/main/pg_hba.conf" 
  fi
  msg "restart postgresql"
  sudo /etc/init.d/postgresql restart

  INSTALLED+="- postgres"
}

install_rbenv() {
  if [ ! -d $HOME/.rbenv ]; then
    msg "installing rbenv"
    git clone git://github.com/sstephenson/rbenv.git $HOME/.rbenv

    msg "rbenv: ruby-build"
    git clone git://github.com/sstephenson/ruby-build.git \
      $HOME/.rbenv/plugins/ruby-build

    msg "rbenv: rbenv-gem-rehash"
    git clone https://github.com/sstephenson/rbenv-gem-rehash.git \
      $HOME/.rbenv/plugins/rbenv-gem-rehash
  else
    msg "updating ruby version"
  fi

  msg "latest ruby"

  rbenv=$HOME/.rbenv/bin/rbenv

  #LATEST=`$rbenv install -l | grep '^\s*2.1.*' | grep -v dev | sort | tail -n 1 | xargs`
  LATEST=`cat /vagrant/.ruby-version`

  msg "LATEST = $LATEST"

  msg  "xxx${rbenv}/version/${LATEST}xxx"

  # Install a ruby
  if [ ! -d "$HOME/.rbenv/versions/${LATEST}/" ]; then
    CONFIGURE_OPTS="--disable-install-doc --with-readline-dir=/usr/include/readline" $rbenv install -v $LATEST 
    msg "Installed ruby $LATEST"
  else
    msg "ruby $LATEST already installed"
  fi

  # Set up environment to use rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' > ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
  source ~/.bash_profile
  msg "bash_profile"

  $rbenv global $LATEST
  $rbenv rehash
  msg "rehashed"

  INSTALLED+="- rbenv"
}

install_rails() {
  echo "gem: --no-document" > $HOME/.gemrc
  gem install bundler
  msg "Install gem bundler"

  cd /vagrant
  bundle install --path vendor
  bundle package
  if [[ ! -n $(grep "vendor/ruby" .gitignore) ]]; then
    echo 'vendor/ruby' >> .gitignore
  fi
  msg "bundle installed"

  RAILS_ENV=production bundle exec rake db:create
  RAILS_ENV=production bundle exec rake db:schema:load

  msg "rake db:created"

  INSTALLED+="- rails"
}


congrats() {
  msg "congrats: $INSTALLED"
}

apt_3rd_party
apt_upgrade
apt_core

install_postgres
install_rbenv
install_rails

apt_clean

congrats
