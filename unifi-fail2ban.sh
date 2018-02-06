#!/bin/bash

#=====================================================================================
# Author: Fabian Müller
# Website: https://itsmind.com
# Description:	This Script adds a Unifi specific filter to fail2ban and adds a jail
# 				that blocks unauthorized logins. The filter is taken from Mike Tabors
#				auto-install script https://github.com/miketabor/unifi-autoinstall
#
#=====================================================================================

echo -e "# Fail2Ban filter for Ubiquiti UniFi\n#\n#\n\n[Definition]\n\n_daemon = unifi\n\nfailregex =^.*Failed .* login .* <HOST>*\s*$
" | tee -a /etc/fail2ban/filter.d/ubiquiti.conf

# Add ubiquiti JAIL to Fail2ban setting log path and blocking IPs after 5 failed logins within 15 minutes for 1 hour.
# The logpath assumes that you"ve installed the controller on a debian system using the apt-packages.
echo -e "\n[ubiquiti]\nenabled  = true\nfilter   = ubiquiti\nlogpath  = /var/log/unifi/server.log\nmaxretry = 5\nbantime = 3600\nfindtime = 900\nport = 8443\nbanaction = iptables[name=ubiquiti, port=8443, protocol=tcp]" | tee -a /etc/fail2ban/jail.local
