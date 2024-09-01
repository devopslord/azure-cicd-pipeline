# Generate AWS key pair

# RSA key
resource "tls_private_key" "RSA" {
  algorithm = "RSA"
}

resource "local_file" "ssh_private_key" {
  content  = tls_private_key.RSA.private_key_pem
  filename = "${path.module}/id_RSA"
}

resource "aws_key_pair" "deployer" {
  key_name   = "azure-agent-key"
  public_key = tls_private_key.RSA.public_key_openssh
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "azure-agent-instance"

  instance_type          = "t2.medium"
  key_name               = aws_key_pair.deployer.key_name
  ami                    = var.ami
  monitoring             = true
  vpc_security_group_ids = [module.ec2SecurityGroup.security_group_id]
  subnet_id              = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true


  tags = {
    Azure   = "true"
    Name = "Azure-Agent"
  }
}