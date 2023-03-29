
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