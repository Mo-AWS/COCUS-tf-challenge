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
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "open ssh port from Anywhere"
        },
        {
          from_port   = -1
          to_port     = -1
          protocol    = "icmp"
          cidr_block  = "0.0.0.0/0"
          description = "open icmp traffic on all ports from Anywhere"
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "open http port from Anywhere"
        },
    ]
}

variable "sg_egress_rules_public" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = -1
          to_port     = -1
          protocol    = "all"
          cidr_block  = "0.0.0.0/0"
          description = "open all egress IPv4 traffic for public subnet"
        },
    ]
}

variable "sg_ingress_rules_private" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "172.16.0.0/24"
          description = "open ssh port"
        },
        {
          from_port   = 3110
          to_port     = 3110
          protocol    = "tcp"
          cidr_block  = "172.16.0.0/24"
          description = "open tcp port 3110"
        },
        {
          from_port   = -1
          to_port     = -1
          protocol    = "icmp"
          cidr_block  = "0.0.0.0/0"
          description = "open icmp port from Anywhere"
        },
    ]
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
