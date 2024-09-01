provider "aws" {
  region = var.region
}

###############################
# get default vpc

data "aws_vpc" "selected" {
  default = true
}

###############################
# get default subnet

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}