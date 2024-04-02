resource "aws_key_pair" "terraform-lab" {
  key_name   = "${var.ec2_instance_name}_key_pair"
  public_key = file(var.ssh_pubkey_file)
}

resource "aws_instance" "bastion" {
  ami                         = lookup(var.amis, var.region)
  instance_type               = "${var.instance_type}"
  key_name                    = aws_key_pair.terraform-lab.key_name
  associate_public_ip_address = true
  security_groups            = [aws_security_group.ec2.id]
  subnet_id                   = aws_subnet.private-subnets[0].id
  tags = {
    Name = "Bastion"
  }
}
