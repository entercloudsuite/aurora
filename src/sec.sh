#!/bin/bash
openstack security group delete aurora_security_group
openstack security group create aurora_security_group
openstack security group rule delete $(openstack security group rule list -c ID -f value aurora_security_group)
openstack security group rule create --egress --protocol=tcp aurora_security_group
openstack security group rule create --egress --protocol=udp aurora_security_group
openstack security group rule create --ingress --protocol=tcp aurora_security_group
openstack security group rule create --ingress --protocol=udp aurora_security_group
