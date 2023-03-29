# Add internet gateway
resource "aws_internet_gateway" "prod-igw" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    tags = {
        Name = "prod-igw"
    }
}

# Public routes
resource "aws_route_table" "prod-public-crt" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = "${aws_internet_gateway.prod-igw.id}" 
    }
    
    tags = {
        Name = "prod-public-crt"
    }
}
resource "aws_route_table_association" "prod-crta-public-subnet-1"{
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    route_table_id = "${aws_route_table.prod-public-crt.id}"
}

# Private routes
resource "aws_route_table" "prod-private-crt" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.prod-nat-gateway.id}" 
    }
    
    tags = {
        Name = "prod-private-crt"
    }
}
resource "aws_route_table_association" "prod-crta-private-subnet-1"{
    subnet_id = "${aws_subnet.prod-subnet-private-1.id}"
    route_table_id = "${aws_route_table.prod-private-crt.id}"
}

# NAT Gateway to allow private subnet to connect out the way
resource "aws_eip" "nat_gateway" {
    vpc = true
}
resource "aws_nat_gateway" "prod-nat-gateway" {
    allocation_id = aws_eip.nat_gateway.id
    subnet_id     = "${aws_subnet.prod-subnet-public-1.id}"

    tags = {
    Name = "VPC Demo - NAT"
    }

    # To ensure proper ordering, add Internet Gateway as dependency
    depends_on = [aws_internet_gateway.prod-igw]
}