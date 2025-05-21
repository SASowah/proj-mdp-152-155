# creating custom vpc
resource "aws_vpc" "devops_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "devops_vpc"
      environment = "project-1"
    }
}

# creating custom subnet 
resource "aws_subnet" "public_devops_subnet_a" {
    vpc_id = aws_vpc.devops_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "public_devops_subnet_a"
      environment = "project-1"
      availability_zone = "us-east-1a"
    } 
}

# creating custom subnet 
resource "aws_subnet" "public_devops_subnet_b" {
    vpc_id = aws_vpc.devops_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "public_devops_subnet_b"
      environment = "project-1"
      availability_zone = "us-east-1b"
    } 
}

# creating Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.devops_vpc.id

    tags = {
      Name = "devops_igw"
      environment = "project-1"
    }
}
  
# creating Route Table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.devops_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "devops-public-rt"
      environment = "project-1"
    }
}

# creating Route Table Association for subnet a
resource "aws_route_table_association" "public_rt_assoc_a" {
    subnet_id = aws_subnet.public_devops_subnet_a.id
    route_table_id = aws_route_table.public_rt.id
}

# creating Route Table Association for subnet b
resource "aws_route_table_association" "public_rt_assoc_b" {
    subnet_id = aws_subnet.public_devops_subnet_b.id
    route_table_id = aws_route_table.public_rt.id
}

# creating security group
resource "aws_security_group" "build_sg" {
    vpc_id = aws_vpc.devops_vpc.id
    name = "build_sg"
    description = "allow ssh inbound traffic for build server"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "build_sg"
      environment = "project-1"
    }
}

# creating security group for Tomcat Server
resource "aws_security_group" "tomcat_sg" {
    vpc_id = aws_vpc.devops_vpc.id
    name = "tomcat_sg"
    description = "allow ssh/http inbound traffic for tomcat server"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "tomcat_sg"
      environment = "project-1"
    }
}

# Build server using Maven
resource "aws_instance" "build_server" {
    ami = "ami-0e58b56aa4d64231b"
    instance_type = "t2.micro"
    key_name = "devkey"
    subnet_id = aws_subnet.public_devops_subnet_a.id
    vpc_security_group_ids = [aws_security_group.build_sg.id]
    user_data              = file("/user_data/build-server.sh")
    

    tags = {
      Name = "BuildServer"
      environment = "project-1"
    }
}

# Tomcat Server (Runtime)
resource "aws_instance" "tomcat_server" {
    ami = "ami-0e58b56aa4d64231b"
    instance_type = "t2.micro"
    key_name = "devkey"
    subnet_id = aws_subnet.public_devops_subnet_b.id
    vpc_security_group_ids = [aws_security_group.tomcat_sg.id]
    user_data              = file("/user_data/tomcat-server.sh")

    tags = {
      Name = "TomcatServer"
      environment = "project-1"
    }
}