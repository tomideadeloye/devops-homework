#!/usr/bin/env bash
set -ex
pushd /home/ubuntu/rescale
  AWS=$(which aws)
  RDS=$("$AWS" rds describe-db-instances --db-instance-identifier rescalepg --query 'DBInstances[*].[Endpoint][*][0].[Address]' --region us-west-2 --output text)
  PASSWORD=$("$AWS" secretsmanager get-secret-value --secret-id RescaleSecret --region us-west-2 --query SecretString --output text | jq '.password' | tr -d \")
  HARDWAREHOST=$("$AWS" elb describe-load-balancers --load-balancer-names HardwareLB --region us-west-2 --query 'LoadBalancerDescriptions[*].[DNSName]' --output text)
  sed -i s"/127.0.0.1/$RDS/" hardware.py
  sed -i s"/randompass/$PASSWORD/" hardware.py
  sed -i s"#http://0.0.0.0:5001#http://$HARDWAREHOST#" portal.py
  pip3 install psycopg2
  pip3 install -r requirements.txt
popd
