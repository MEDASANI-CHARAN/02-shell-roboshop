#!/bin/bash

# AMI_ID="ami-09c813fb71547fc4f"
# SG_ID="sg-074b66f88e51305b4"
# INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
# ZONE_ID="Z079925038GKLPVTTRWKU"
# DOMAIN_NAME="daws2025.online"

# # Allow optional single component argument
# if [ -n "$1" ]; then
#   INSTANCES=("$1")
# fi

# for instance in "${INSTANCES[@]}"
# do
#   INSTANCE_ID=$(/usr/local/bin/aws ec2 run-instances \
#     --image-id "$AMI_ID" \
#     --count 1 \
#     --instance-type t2.micro \
#     --security-group-ids "$SG_ID" \
#     --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
#     --query 'Instances[0].InstanceId' \
#     --output text)

#   # Debug info (InstanceId, Public IP, Private IP)
#   /usr/local/bin/aws ec2 describe-instances \
#     --instance-ids "$INSTANCE_ID" \
#     --query 'Reservations[0].Instances[0].[InstanceId,PublicIpAddress,PrivateIpAddress]' \
#     --output text 

#   if [ "$instance" != "frontend" ]; then
#     IP=$(/usr/local/bin/aws ec2 describe-instances \
#       --instance-ids "$INSTANCE_ID" \
#       --query 'Reservations[0].Instances[0].PrivateIpAddress' \
#       --output text)
#   else
#     IP=$(/usr/local/bin/aws ec2 describe-instances \
#       --instance-ids "$INSTANCE_ID" \
#       --query 'Reservations[0].Instances[0].PublicIpAddress' \
#       --output text)
#   fi

#   echo "$instance IP address: $IP"

# done


# #!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-074b66f88e51305b4"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z079925038GKLPVTTRWKU"
DOMAIN_NAME="daws2025.online"

for instance in ${INSTANCES[@]}
do
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --count 1 \
  --instance-type t2.micro \
  --security-group-ids $SG_ID \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$instance}]' \
  --query 'Instances[0].InstanceId' \
  --output text)

aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].[InstanceId,PublicIpAddress,PrivateIpAddress]' \
  --output text 

if [ $instance != "frontend" ]
then
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