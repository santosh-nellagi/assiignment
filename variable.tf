variable "AWS_REGION" {    
    default = "ap-south-1"
}
variable "AMI" {
    type = map(string)

    default = {
        # For demo purposes only, we are using ubuntu for the web1 and db1 instances
        ap-south-1 = "ami-02eb7a4783e7e9317" # Ubuntu 20.04 x86
    }
}
variable "EC2_USER" {
    default = "ubuntu"
}
variable "PUBLIC_KEY_PATH" {
    default = "~/.ssh/id_rsa.pub" # Replace this with a path to your public key
}

