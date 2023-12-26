#!/bin/bash
sudo yum update -y 
##Adding cluster name in ecs config
echo ECS_CLUSTER=app-cluster >> /etc/ecs/ecs.config
