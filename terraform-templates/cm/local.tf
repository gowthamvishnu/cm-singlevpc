# Define the mapping of regions to AMI IDs
locals {
  ami_map = {
    "us-east-1"  = "ami-051f7e7f6c2f40dc1"
    "us-east-2"  = "ami-0cf0e376c672104d6"
    "us-west-1"  = "ami-03f2f5212f24db70a"
    "us-west-2"  = "ami-002829755fa238bfa"
    "ap-south-1" = "ami-06f621d90fa29f6d0"
    "eu-north-1" = "ami-065681da47fb4e433"
  }
}
locals {
  ami_ubuntu = {
    "us-east-1"  = "ami-053b0d53c279acc90"
    "us-east-2"  = "ami-024e6efaf93d85776"
    "us-west-1"  = "ami-0f8e81a3da6e2510a"
    "us-west-2"  = "ami-03f65b8614a860c29"
    "ap-south-1" = "ami-0f5ee92e2d63afc18"
    "eu-north-1" = "ami-0989fb15ce71ba39e"
  }
}
