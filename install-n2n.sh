#!/bin/bash

function log-debug() {
  echo -e "\033[37m[debug] $1\033[0m"
}

function log-info() {
  echo -e "\033[32m[info] $1\033[0m"
}

function log-warn() {
  echo -e "\033[33m[warning] $1\033[0m"
}

function log-error() {
  echo -e "\033[31m[error] $1\033[0m"
}

# root need
case $USER in
root) ;;

*)
  log-error "This script must be run as root!"
  exit 1
  ;;
esac

log-info "installing n2n"
# mkdir /etc/n2n
if [ ! -d "/etc/n2n" ]; then
  mkdir -p /etc/n2n
fi

# cp bin file
if [ ! -d "/opt/n2n" ]; then
  cp -r . /opt/n2n
else
  log-info "/opt/n2n existed, mv it to /opt/n2n.bak"
  cp -r /opt/n2n /opt/n2n.bak
  cp -r . /opt/n2n
fi

cp /etc/n2n/edge.conf /etc/n2n/edge.conf.bak
cp conf/edge.conf /etc/n2n/edge.conf
