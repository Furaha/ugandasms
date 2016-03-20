#!/usr/bin/env bash 

set -e

export DEBIAN_FRONTEND=noninteractive 

<<<<<<< HEAD:bootstrap.sh
INSTALLED="Installed:"
=======
VAGRANT=/vagrant
RELEASE=$(lsb_release --codename --short)

INSTALLED="Installed:\n"
>>>>>>> master:bootstrap/default.sh

msg() 
{ 
  echo "*****************************************************************"
  echo -e "$1"
}

apt()
{
  msg "Installing $1"
  apt-get install -y --force-yes $1
}

apt_3rd_party()
{

  apt software-properties-common

  # node.js  repo
  add-apt-repository ppa:chris-lea/node.js 

  # brightbox ruby
  add-apt-repository ppa:brightbox/ruby-ng

  # passenger
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
  apt-get install -y apt-transport-https ca-certificates
  echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger $RELEASE main" > /etc/apt/sources.list.d/passenger.list

  apt-get update

  apt "ruby2.3 nodejs nginx-extras passenger"
}

<<<<<<< HEAD:bootstrap.sh
apt_upgrade() {
  if [ "$[$(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin)]" -ge 3600 ]; then
=======
apt_upgrade()
{
  if [ "$[$(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin)]" -ge 3600 ]
  then
>>>>>>> master:bootstrap/default.sh
    msg "APT update"
    apt-get update
    msg "APT dist-upgrade"
    apt-get dist-upgrade -q -y --force-yes 
    INSTALLED+="- apt-upgrade"
  fi
}

<<<<<<< HEAD:bootstrap.sh
apt_core() {
  pkgs="curl git-core screen tmux vim zerofree ntpdate"
  pkgs="$pkgs zlib1g-dev build-essential libssl-dev libreadline-dev"
  pkgs="$pkgs libyaml-dev libxml2-dev libxslt1-dev libffi-dev" 
  pkgs="$pkgs libcurl4-openssl-dev python-software-properties nodejs"
  pkgs="$pkgs imagemagick libmagickwand-dev libgmp-dev libsqlite3-dev sqlite3"
  
=======
apt_core()
{

  apt-get update

  msg "Preparing to install packages"

  pkgs="curl git screen tmux vim zerofree ntpdate"
  pkgs="$pkgs zlib1g-dev build-essential libssl-dev libreadline-dev"
  pkgs="$pkgs libyaml-dev libxml2-dev libxslt1-dev" 
  pkgs="$pkgs libcurl4-openssl-dev python-software-properties"
  pkgs="$pkgs imagemagick libmagickwand-dev"
  pkgs="$pkgs postgresql libpq-dev postgresql-server-dev-all postgresql-contrib"
>>>>>>> master:bootstrap/default.sh

  apt "$pkgs"

  ntpdate -u pool.ntp.org
}

apt_clean()
{
  msg "APT clean"
  apt-get -y autoremove
  apt-get -y clean
  apt-get autoclean -y

  INSTALLED+="- apt-clean"
}

setup_postgres()
{
  msg "postgresql"

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
  /etc/init.d/postgresql restart

  INSTALLED+="- postgres"
}

install_rbenv()
{
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
<<<<<<< HEAD:bootstrap.sh
  if [ ! -d "$HOME/.rbenv/versions/${LATEST}/" ]; then
    CONFIGURE_OPTS="--disable-install-doc --with-readline-dir=/usr/include/readline" $rbenv install -v $LATEST 
    msg "Installed ruby $LATEST"
  else
    msg "ruby $LATEST already installed"
=======
  if [[ ! -d "$rbenv/version/$LATEST" ]]; then
    if [[ ! $(ruby -v) =~ "ruby $LATEST" ]]; then 
      CONFIGURE_OPTS="--disable-install-doc --with-readline-dir=/usr/include/readline" $rbenv install -v $LATEST
      $rbenv global  $LATEST
      $rbenv rehash
      echo "Installed ruby $LATEST"

      $HOME/.rbenv/shims/gem install bundler
      echo "Install gem bundler"
    else
      echo "ruby $LATEST already installed"
    fi
>>>>>>> master:bootstrap/default.sh
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

<<<<<<< HEAD:bootstrap.sh
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
=======
setup_deploy()
{

  local DEPLOY="/home/deploy/.ssh"

  msg "create user deploy"
  id -u deploy &>/dev/null || useradd deploy 
  msg "add user deploy to sudoers"
  adduser deploy sudo

  msg "deploy .ssh"
  if [[ ! -d $DEPLOY ]]; then
    mkdir -p /home/deploy/.ssh
  fi

  msg "deploy keys"
  if [[ -d "$VAGRANT" ]]; then
    cp $VAGRANT/id_rsa $DEPLOY
    cp $VAGRANT/id_rsa.pub $DEPLOY
  else
    cp ./id_rsa $DEPLOY
    cp ./id_rsa.pub $DEPLOY
  fi

  chown -R deploy:deploy $DEPLOY 
  chmod 700 $DEPLOY
  chmod 600 $DEPLOY/id_rsa
  chmod 644 $DEPLOY/id_rsa.pub
}

setup_nginx()
{
  msg "TODO"
}
>>>>>>> master:bootstrap/default.sh

sleep5()
{
  sleep 5
}
congrats()
{
  echo "$INSTALLED"
}

#sleep5 && apt_core && \
#sleep5 && apt_upgrade && \
#sleep5 && apt_3rd_party && \
#sleep5 && apt_clean && \
#sleep5 && setup_postgres && \
#sleep5 && setup_deploy && \
sleep5 && setup_nginx && \
sleep5 && congrats
