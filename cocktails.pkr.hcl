packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
    timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "cocktails" {
  ami_name = "cocktails_ami-${local.timestamp}"
  source_ami = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"
  region = "us-east-1"
  ssh_username  = "ec2-user"
  source_ami_filter {
    filters = {
      name                = "al2023-ami-2023.*-kernel-6.1-x86_64"
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }
    owners      = ["amazon"] 
    most_recent = true

  }
}
build {
  sources = [
    "source.amazon-ebs.cocktails"
  ]
 

  provisioner "file" {
   source = "cocktails.zip"
   destination = "/home/ec2-user/cocktails.zip"
 }

  provisioner "file" {
   source = "cocktails.service"
   destination = "/tmp/cocktails.service"
 }

  provisioner "shell" {
  inline = [
    "sudo yum update -y",
    "sudo yum install -y gcc-c++ make unzip",
    "curl -sL https://rpm.nodesource.com/setup_20.x | sudo -E bash -",
    "sudo yum install -y nodejs",
    "cd /home/ec2-user && unzip cocktails.zip",
    "cd /home/ec2-user/cocktails && npm i --only=prod",
    "sudo mv /tmp/cocktails.service /etc/systemd/system/cocktails.service",
    "sudo systemctl enable cocktails.service",
    "sudo systemctl start cocktails.service"
  ]
}

}

