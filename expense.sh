#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-074b66f88e51305b4"
INSTANCES=("mysql" "backend" "frontend")
ZONE_ID="Z079925038GKLPVTTRWKU"
DOMAIN_NAME="daws2025.online"

# for instance in "${INSTANCES[@]}"
for instance in "$@"
  do
    echo "Creating EC2 instance for: $instance"

    INSTANCE_ID=$(aws ec2 run-instances \
      --image-id $AMI_ID \
      --count 1 \
      --instance-type t2.micro \
      --security-group-ids $SG_ID \
      --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
      --query 'Instances[0].InstanceId' \
      --output text)

    echo "$instance instance created with ID: $INSTANCE_ID"

    # Get IP address
    if [ "$instance" != "frontend" ]; then
      IP=$(aws ec2 describe-instances \
        --instance-ids $INSTANCE_ID \
        --query 'Reservations[0].Instances[0].PrivateIpAddress' \
        --output text)
    else
      IP=$(aws ec2 describe-instances \
        --instance-ids $INSTANCE_ID \
        --query 'Reservations[0].Instances[0].PublicIpAddress' \
        --output text)
    fi

    echo "$instance IP address: $IP"
    
  done