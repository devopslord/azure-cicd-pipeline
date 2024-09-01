module "ec2SecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"


  name        = "Azure-agent-sg"
  description = "Security group for Azure agent instance"
  vpc_id      = data.aws_vpc.selected.id


  ingress_with_cidr_blocks = [
    {
      protocol        = "tcp"
      from_port       = 22
      to_port         = 22
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      protocol    = "-1"
      from_port   = 0
      to_port     = 65535
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

