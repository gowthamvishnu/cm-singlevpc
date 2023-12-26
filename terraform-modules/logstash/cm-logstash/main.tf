locals {
    tags = {
    "environment" = "${var.environment}",
    "Region" = "${var.aws_region}",
    "requestor" = "${var.requestor}",
    "customer" = "${var.customer}",
    "tenant" = "${var.tenant}",
    "product" = "${var.product}",
    "manager" = "${var.manager}",
    "owner" = "${var.owner}",
    "purpose" = "${var.purpose}"
  }
}

data "aws_ami" "lt_image" {
  count = var.ami_id != "" ? 0 : 1
  most_recent      = true
  name_regex       = "^Ondot AmazonLinux2 Golden Image-\\d{3}"
  owners           = ["self"]
  filter {
    name   = "name"
    values = ["Ondot AmazonLinux2 Golden Image-*"]
  }
}


resource "aws_instance" "logstash-instance" {
  instance_type   = var.instance_type
  ami             = var.ami_id != "" ? var.ami_id : data.aws_ami.lt_image[0].id
  subnet_id       = var.subnet_id
  security_groups = var.security_groups
    tags = merge(
    local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-Server"}
  )
  key_name  = var.logstash_key_name
  # key_name  = aws_key_pair.logstash_key.key_name
  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-keyring.gpg
                sudo apt-get install apt-transport-https
                echo "deb [signed-by=/usr/share/keyrings/elastic-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
                sudo apt-get update && sudo apt-get install logstash
                sudo systemctl start logstash
                sudo systemctl enable logstash
              EOF
}

# resource "tls_private_key" "logstash_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "logstash_key" {
#   key_name   = "${var.product}-${var.environment}-${var.resource_name}-key"
#   public_key = tls_private_key.logstash_key.public_key_openssh

#   tags = merge(
#     local.tags, {"Name" = "${var.product}-${var.environment}-${var.resource_name}-key"}
#   )
# }
