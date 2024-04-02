

variable "region" {
  default = "us-east-1"
}
variable "vpc" {
    type    = map(string)
    default = {
        "tag"         = "my-vpc"
        "cidr_block"  = "10.10.0.0/16"
        "subnet_bits" = "4"
    }
}

variable "az_map" {
    type = map(list(string))
    default = {
        "us-east-1"   = ["us-east-1a","us-east-1b","us-east-1c"]
    }
}


variable "amis" {
  description = "Which AMI to spawn."
  default = {
    us-east-1 = "ami-05fa00d4c63e32376"
  }
}
variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_instance_name" {
  default     = "terraform-ec2"
}

variable "ssh_pubkey_file" {
  default     = "~/.ssh/aws_key.pub"
}
variable "health_check_path" {
  default = "/health"
}