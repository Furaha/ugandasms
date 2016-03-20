include apt

user { 'deploy':
  ensure => 'present',
  groups => 'sudo',
}

package { 'software-properties-common': ensure => latest, } ->
apt::ppa { 'ppa:brightbox/ruby-ng': } ->
exec { 'apt-get update':
  command => "/usr/bin/apt-get update",
  onlyif => "/bin/bash -c 'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1 )) )) <= 604800 ))'"
} ->
package { 'ruby2.3': ensure => present, }


