
### create security group for ec2 instances that are lunched in public subnet
resource "aws_security_group" "public_ports_security_groups" {
  name   = "public_ports_security_groups"
  vpc_id = aws_vpc.awslab-vpc.id
}

### create ingress rules for public security group
resource "aws_security_group_rule" "sg_ingress_rules_public" {
  count             = length(var.sg_ingress_rules_public)
  type              = "ingress"
  from_port         = var.sg_ingress_rules_public[count.index].from_port
  to_port           = var.sg_ingress_rules_public[count.index].to_port
  protocol          = var.sg_ingress_rules_public[count.index].protocol
  cidr_blocks       = [var.sg_ingress_rules_public[count.index].cidr_block]
  description       = var.sg_ingress_rules_public[count.index].description
  security_group_id = aws_security_group.public_ports_security_groups.id
}

### create egress rules for public security group
resource "aws_security_group_rule" "sg_egress_rules_public" {
  count             = length(var.sg_egress_rules_public)
  type              = "egress"
  from_port         = element(var.sg_egress_rules_public.cidr[count.index], 0)
  to_port           = element(var.sg_egress_rules_public.cidr[count.index], 1)
  protocol          = element(var.sg_egress_rules_public.cidr[count.index], 2)
  cidr_blocks       = [element(var.sg_egress_rules_public.cidr[count.index], 3)]
  description       = element(var.sg_egress_rules_public.cidr[count.index], 4)
  security_group_id = aws_security_group.public_ports_security_groups.id
}


### create security group for ec2 instances that are lunched in private subnet
resource "aws_security_group" "private_ports_security_groups" {
  name   = "private_ports_security_groups"
  vpc_id = aws_vpc.awslab-vpc.id
}


### create ingress rules for private subnet security group
resource "aws_security_group_rule" "sg_ingress_rules_private" {
  count             = length(var.sg_ingress_rules_private)
  type              = "ingress"
  from_port         = var.sg_ingress_rules_private[count.index].from_port
  to_port           = var.sg_ingress_rules_private[count.index].to_port
  protocol          = var.sg_ingress_rules_private[count.index].protocol
  cidr_blocks       = [var.sg_ingress_rules_private[count.index].cidr_block]
  description       = var.sg_ingress_rules_private[count.index].description
  security_group_id = aws_security_group.private_ports_security_groups.id
}

### create egress rules for private security group
resource "aws_security_group_rule" "sg_egress_rules_private" {
  count             = length(var.sg_egress_rules_private)
  type              = "egress"
  from_port         = element(var.sg_egress_rules_private.cidr[count.index], 0)
  to_port           = element(var.sg_egress_rules_private.cidr[count.index], 1)
  protocol          = element(var.sg_egress_rules_private.cidr[count.index], 2)
  cidr_blocks       = [element(var.sg_egress_rules_private.cidr[count.index], 3)]
  description       = element(var.sg_egress_rules_private.cidr[count.index], 4)
  security_group_id = aws_security_group.private_ports_security_groups.id
}