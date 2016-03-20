#!/usr/bin/env bash 

set -e

export DEBIAN_FRONTEND=noninteractive 

INSTALLED="Installed:"

VAGRANT=/vagrant
if [ ! -d $VAGRANT ]; then
  mkdir -p $VAGRANT/bootstrap
  cp -r * $VAGRANT/bootstrap
fi

RELEASE=$(lsb_release --codename --short)

INSTALLED="Installed:\n"

msg() { 
  echo " "
  echo " "
  echo "*****************************************************************"
  echo "*****************************************************************"
  echo -e "$1"
  echo " "
  echo " "
}

msgs() {
  echo " "
  echo -e "***  $1"
  echo " "
}

apt() {
  msgs "apt() install $1"
  apt-get install -y --force-yes $1
}

apt_update() {
  if [ "$[$(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin)]" -ge 3600 ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null; then
    msgs "apt_update()"
    apt-get update
  else
    msgs "apt_update() not needed"
  fi
}

apt_upgrade() {
  msg "apt_upgrade()"

  apt_update

  if [ "$[$(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin)]" -ge 3600 ]; then
    msgs "APT dist-upgrade"
    apt-get dist-upgrade -q -y --force-yes 
    INSTALLED+="- apt-upgrade"
  fi
}

apt_core() {
  msg "apt_core()"

  apt_update

  pkgs="curl git screen tmux vim zerofree ntpdate"
  pkgs="$pkgs zlib1g-dev build-essential libssl-dev libreadline-dev"
  pkgs="$pkgs libyaml-dev libxml2-dev libxslt1-dev" 
  pkgs="$pkgs libcurl4-openssl-dev software-properties-common"
  pkgs="$pkgs imagemagick libmagickwand-dev"
  pkgs="$pkgs postgresql libpq-dev postgresql-server-dev-all postgresql-contrib"
  pkgs="$pkgs apt-transport-https ca-certificates"

  apt "$pkgs"

  ntpdate -u pool.ntp.org
}

apt_3rd_party() {
  msg "apt_3rd_party()"

  # node.js  repo
  if [ ! -f /etc/apt/sources.list.d/chris-lea-node_js-$RELEASE.list ]; then
    msgs "apt_3rd_party() node.js" 
    add-apt-repository ppa:chris-lea/node.js 
  else
    msgs "apt_3rd_party() node.js already installed" 
  fi

  # brightbox ruby
  if [ ! -f /etc/apt/sources.list.d/brightbox-ruby-ng-$RELEASE.list ]; then
    msgs "apt_3rd_party() brightbox ruby" 
    add-apt-repository ppa:brightbox/ruby-ng
  else
    msgs "apt_3rd_party() brightbox ruby already installed" 
  fi

  # passenger
  local PASSENGER="deb https://oss-binaries.phusionpassenger.com/apt/passenger $RELEASE main"
  local PASSAPT="/etc/apt/sources.list.d/passenger.list"
  msgs "PASSENGER $PASSENGER"
  msgs "PASSAPT $PASSAPT"
  if [ ! -f /etc/apt/sources.list.d/passenger.list ]; then
    msgs "apt_3rd_party() passenger" 
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 
    echo "$PASSENGER" > $PASSAPT
  else
    msgs "apt_3rd_party() passenger already installed" 
  fi

  apt_update

  apt "ruby2.3 nodejs nginx-extras passenger"
}

apt_clean() {
  msg "apt_clean()"
  apt-get -y autoremove
  apt-get -y clean
  apt-get autoclean -y

  INSTALLED+="- apt-clean"
}

setup_postgres() {
  msg "setup_postgresql()"

  # install pgcrypto module
  #if [[ ! $(sudo -u postgres psql template1 -c '\dx') =~ pgcrypto ]]; then
  #  sudo -u postgres psql template1 -c 'create extension pgcrypto'
  #fi

  local PVER=$(psql -V | grep -Eo "[[:digit:]].[[:digit:]]")
  if diff -q $VAGRANT/bootstrap/pg_hba.conf /etc/postgresql/$PVER/main/pg_hba.conf > /dev/null; then
    msgs "pg_hba.conf up to date"
  else
    msgs "pg_hba.conf needs updating"
    cat $VAGRANT/bootstrap/pg_hba.conf > /etc/postgresql/$PVER/main/pg_hba.conf
    msgs "restart postgresql"
    /etc/init.d/postgresql restart
  fi

  INSTALLED+="- postgres"
}

setup_deploy() {
  msg "setup_deploy()"

  local DEPLOY="/home/deploy/.ssh"

  msgs "create user deploy"
  id -u deploy &>/dev/null || useradd deploy 
  msgs "add user deploy to sudoers"
  adduser deploy sudo

  msgs "deploy .ssh"
  if [[ ! -d $DEPLOY ]]; then
    mkdir -p /home/deploy/.ssh
  fi

  msgs "deploy keys"
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

setup_nginx() {
  msg "TODO"
}

sleep5() {
  sleep 0
}

congrats() {
  echo "$INSTALLED"
}

sleep5 && apt_upgrade && \
sleep5 && apt_core && \
sleep5 && apt_3rd_party && \
sleep5 && apt_clean && \
sleep5 && setup_postgres && \
sleep5 && setup_deploy && \
sleep5 && setup_nginx && \
sleep5 && congrats

