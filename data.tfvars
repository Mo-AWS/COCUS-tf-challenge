
# data "aws_ami" "instance_ami" {
#   most_recent = true

#   owners = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*"]
#   }
# ### amzn2-ami-hvm-*-x86_64-ebs
#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

