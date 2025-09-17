# ec2 

resource "aws_instance" "server" {
    ami = "ami-0b09ffb6d8b58ca91"
    instance_type = "t2.micro"
    subnet_id = var.sn
    security_groups =  [var.sg]

    tags = {
        Name = "myserver"
    }
}