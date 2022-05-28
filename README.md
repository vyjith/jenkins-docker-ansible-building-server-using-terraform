# jenkins-docker-ansible-building-server-using-terraform


jenkins,docker and ansible servers building using terraform, the advantage of this, you can remove this server once your testing is complete using terraform destroy command.


```sh
## Creating a new key pair for my project

resource "aws_key_pair" "jenkinskey" {
  key_name   = "deployer-key"
  public_key = file("your public key file name is here (eg: key.pub)")
}

# Security group creating, all traffic allow

resource "aws_security_group" "allow" {
  name        = "allow_from_all"
  description = "Allow from all traffic"

  ingress {
    description      = ""
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.jenkinsproject}-freedom"
  }
}
# ec2 instance creating for jenkins project

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amazonami.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.jenkinskey.id
  user_data = file("jenkins.sh")
  vpc_security_group_ids = [ aws_security_group.allow.id ]

  tags = {
    Name = "${var.jenkinsproject}-project"
  }
}

# ec2 instance creating for docker project

resource "aws_instance" "docker" {
  ami           = data.aws_ami.amazonami.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.jenkinskey.id
  user_data = file("docker.sh")
  vpc_security_group_ids = [ aws_security_group.allow.id ]

  tags = {
    Name = "${var.docker_project}-project"
  }
}

# ec2 instance creating for ansible project

resource "aws_instance" "ansible" {
  ami           = data.aws_ami.amazonami.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.jenkinskey.id
  user_data = file("ansible.sh")
  vpc_security_group_ids = [ aws_security_group.allow.id ]

  tags = {
    Name = "${var.ansible_project}-project"
  }
}
```
