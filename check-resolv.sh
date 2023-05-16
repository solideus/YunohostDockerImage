#!/bin/bash


# 1. Check if /etc/resolv.conf is a symlink.
if [[ -L "/etc/resolv.conf" ]]; then
  # echo "It's a link!"
  # 4. Check if it links to a valid path.
  if [[ -e "/etc/resolvconf/run/resolv.conf" ]]
  then
    :
  else
    systemctl stop etc-resolv.conf.mount
    rm /etc/resolv.conf
    ln -s /etc/resolvconf/run/resolv.conf /etc/resolv.conf
    echo "Not valid resolv.conf symlink, changed!"
    # systemctl restart dnsmasq.service
  fi
else
  systemctl stop etc-resolv.conf.mount
  rm /etc/resolv.conf
  ln -s /etc/resolvconf/run/resolv.conf /etc/resolv.conf
  echo "Not valid resolv.conf file, changed!"
  # systemctl restart dnsmasq.service
fi

chmod 644 /etc/resolvconf/run/resolv.conf
echo -e nameserver 127.0.0.1 > /etc/resolvconf/run/resolv.conf
chmod 444 /etc/resolvconf/run/resolv.conf

exit
