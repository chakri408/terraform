#cloud-config
hostname: ${account_name}
fqdn: ${account_name}.svc10889.com
manage_etc_hosts: true

runcmd:
  - "perl -p -i -e 's/svc-service-dev/${account_name}/g' `grep -ril scv-service-dev /opt/appdynamics/machine-agent/monitors/*`"
