#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-074b66f88e51305b4"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z079925038GKLPVTTRWKU"
DOMAIN_NAME="daws2025.online"

for instance in ${INSTANCES[@]}
do
aws ec2 run-instances \
--image-id ami-09c813fb71547fc4f \
--count 1 \
--instance-type t2.micro \
--security-group-ids sg-074b66f88e51305b4 \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=test}]' \
--query 'Instances[0].InstanceId' \
--query 'Instances[0].PublicIpAddress' \
--query 'Instances[0].PrivateIpAddress' \
--output text
done
