# Security Group
resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // Do not use this in production, should be limited to your own IP
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ssh-allowed"
    }
}


resource "aws_instance" "web1" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"

    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
    key_name = "${aws_key_pair.publikeypair01.id}"

    tags = {
        Name: "My VPC Demo 2"
    }
}
// Sends your public key to the instance
resource "aws_key_pair" "publikeypair01" {
    key_name = "publikeypair01"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}