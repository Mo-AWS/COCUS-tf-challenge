variable "dns_support" {
  description = "Whether or not the VPC has DNS support"
  type        = bool
  default     = true
}

variable "network_usage_metric" {
  description = "Whether Network Address Usage metrics are enabled for the VPC"
  type        = bool
  default     = true
}

variable "dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  type        = bool
  default     = true
}


variable "availability_zone" {
  description = "AZ for the subnet."
  type        = string
  default     = ""
}


variable "availability_zone_id" {
  description = "AZ ID of the subnet. This argument is not supported in all regions or partitions. If necessary, use availability_zone instead."
  type        = string
  default     = ""
}


variable "sg_ingress_rules_public" {
  type = map(list(list(string)))
  default = {
    cidr = [
      ["80", "80", "tcp", "0.0.0.0/0", "open http port from Anywhere-IPv4"],
      ["0", "65535", "icmp", "0.0.0.0/0", "open icmp traffic on all ports from Anywhere-IPv4"],
      ["22", "22", "tcp", "0.0.0.0/0", "open ssh port from Anywhere-IPv4"]
  ] }
}

variable "sg_ingress_rules_private" {
  type = map(list(list(string)))
  default = {
    cidr = [
      ["3110", "3110", "tcp", "172.16.0.0/24", "open tcp port 3110 from vpc cidr"],
      ["0", "65535", "icmp", "0.0.0.0/0", "open icmp traffic on all ports from Anywhere-IPv4"],
      ["22", "22", "tcp", "172.16.0.0/24", "open ssh port from vpc cidr"]
    ]
  }
}

variable "sg_egress_rules_public" {
  type = map(list(list(string)))
  default = {
    cidr = [
      ["0", "0", "-1", "0.0.0.0/0", "open all egress IPv4 traffic for public subnet"]
    ]
  }
}

variable "sg_egress_rules_private" {
  type = map(list(list(string)))
  default = {
    cidr = [
      ["0", "0", "-1", "172.16.0.0/24", "open all egress IPv4 traffic for public subnet"]
    ]
  }
}

variable "instance_type" {
  description = "Instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
    type = string
    default = "ami-070b208e993b59cea"
}

# variable "instance_key" {
#   description = "Key name of the Key Pair to use for the instance; which can be managed using the aws_key_pair resource."
#   type        = string
# }
