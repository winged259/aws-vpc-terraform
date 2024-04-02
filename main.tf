#Define provider
provider "aws" {
  region = var.region
}
resource "aws_vpc" "terraform-vpc" {
    cidr_block           = var.vpc["cidr_block"]
    enable_dns_support   = true
    enable_dns_hostnames = true 
    tags  = {
        Name        = "VPC-${var.vpc["tag"]}"
    }
}

resource "aws_subnet" "public-subnets" {
    vpc_id            = aws_vpc.terraform-vpc.id
    count             = length(lookup(var.az_map, var.region))
    cidr_block        = cidrsubnet(var.vpc["cidr_block"], var.vpc["subnet_bits"], count.index)
    availability_zone = element(lookup(var.az_map, var.region), count.index)
    tags = {
        Name          = "${var.vpc["tag"]}-public-subnet-${count.index}"
    }
    map_public_ip_on_launch = true
}

resource "aws_subnet" "private-subnets" {
    vpc_id            = aws_vpc.terraform-vpc.id
    count             = length(lookup(var.az_map, var.region))
    cidr_block        = cidrsubnet(var.vpc["cidr_block"], var.vpc["subnet_bits"], count.index + length(lookup(var.az_map, var.region)))
    availability_zone = element(lookup(var.az_map, var.region), count.index)
    tags = {
        Name          = "${var.vpc["tag"]}-private-subnet-${count.index}"
        Network       = "private"
    }
}