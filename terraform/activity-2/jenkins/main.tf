provider "aws" {
  region = "us-east-1"
}

# creating custom vpc
resource "aws_vpc" "jenkins_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "jenkins_vpc"
    }
}

# creating custom subnet 
resource "aws_subnet" "public_subnet_a" {
    vpc_id = aws_vpc.jenkins_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "jenkins-public-subnet_a"
    } 
}

# creating Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.jenkins_vpc.id

    tags = {
      Name = "jenkins_igw"
    }
}
  
# creating Route Table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.jenkins_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "jenkins-public-rt"
    }
}

# creating Route Table Association for subnet a
resource "aws_route_table_association" "public_rt_assoc_a" {
    subnet_id = aws_subnet.public_subnet_a.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0e58b56aa4d64231b" # Amazon Linux 2 AMI
  instance_type = "t2.medium"
  key_name      = var.key_name
  subnet_id = aws_subnet.public_subnet_a.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true

  user_data = file("${path.module}/user_data/jenkins-install.sh")


  tags = {
    Name = "JenkinsInstance"
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow ssh and access to Jenkins"
  vpc_id      = aws_vpc.jenkins_vpc.id   # ✅ ADD THIS

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow access to Jenkins"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ssh access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins_sg"
  }
}
