
### create "awslab-vpc" vpc
resource "aws_vpc" "awslab-vpc" {
  cidr_block                           = "172.16.0.0/23"
  enable_dns_support                   = var.dns_support
  enable_network_address_usage_metrics = var.network_usage_metric
  enable_dns_hostnames                 = var.dns_hostnames

  tags = {
    Name = "awslab-vpc"
  }
}


### create "awslab-subnet-public" public subnet
resource "aws_subnet" "awslab-subnet-public" {
  vpc_id     = aws_vpc.awslab-vpc.id
  cidr_block = "172.16.0.0/24"

  availability_zone    = var.availability_zone != "" ? var.availability_zone : null
  availability_zone_id = var.availability_zone_id != "" ? var.availability_zone_id : null ### it will add avaialability zone Id if it is provided as variable, else will not add it to the resource

  tags = {
    Name = "awslab-public"
  }
}

### create "awslab-subnet-private" private subnet
resource "aws_subnet" "awslab-subnet-private" {
  vpc_id     = aws_vpc.awslab-vpc.id
  cidr_block = "172.16.1.0/24"

  availability_zone    = var.availability_zone != "" ? var.availability_zone : null
  availability_zone_id = var.availability_zone_id != "" ? var.availability_zone_id : null ### it will add avaialability zone Id if it is provided as variable, else will not add it to the resource

  tags = {
    Name = "awslab-private"
  }
}


### create Internet gateway to provide Ingress and Egress access for public subnet
resource "aws_internet_gateway" "awslab-igw" {
  vpc_id = aws_vpc.awslab-vpc.id

  tags = {
    Name = "awslab-igw"
  }
}


### create a route for sending none vpc traffic to the internetgateway
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.awslab-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.awslab-igw.id
  }

  tags = {
    Name = "public-route"
  }
}


### assign route to "awslab-subnet-public" public subnet
resource "aws_route_table_association" "public-route-association" {
  subnet_id      = aws_subnet.awslab-subnet-public.id
  route_table_id = aws_route_table.public-route.id
}