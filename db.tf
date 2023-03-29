# This is just a mock example of a database to test out VPCs
resource "aws_instance" "db1" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"

    subnet_id = "${aws_subnet.prod-subnet-private-1.id}"
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
    key_name = "${aws_key_pair.publikeypair01.id}"

    tags = {
        Name: "My VPC Demo DB"
    }
}