#!/usr/bin/env bash 

set -e

install_puppet() {
  apt-get install --yes lsb-release
  DISTRIB_CODENAME=$(lsb_release --codename --short)
  DEB="puppetlabs-release-pc1-${DISTRIB_CODENAME}.deb"
  DEB_PROVIDES="/etc/apt/sources.list.d/puppetlabs.list" # Assume that this file's existence means we have the Puppet Labs repo added

  echo "Installing on $DISTRIB_CODENAME"

  if [ ! -e $DEB_PROVIDES  ]
  then
    # Print statement useful for debugging, but automated runs of this will interpret any output as an error
    # print "Could not find $DEB_PROVIDES - fetching and installing $DEB"
    wget -q http://apt.puppetlabs.com/$DEB
    sudo dpkg -i $DEB
  fi
  sudo apt-get update
  sudo apt-get install --yes puppet-agent

  export PATH=/opt/puppetlabs/bin:$PATH

  puppet module install puppetlabs-apt
}

install_puppet
