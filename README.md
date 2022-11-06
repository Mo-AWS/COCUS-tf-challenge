
VPC name (CIDR): awslab-vpc (172.16.0.0/23)
 Subnet name (CIDR): awslab-subnet-public (172.16.0.0/24)
o Access to or from the internet: To and from
 Subnet name (CIDR): awslab-subnet-private (172.16.1.0/24)
o Access to or from the internet: No
AMI: Amazon Linux 2
Storage size: 8 GB
Region: any
Security Group public ports: 
Type Protocol Port Source Address Comments
HTTP TCP 80 Anywhere 0.0.0.0/0
ICMP ICMP 0-65535 Anywhere 0.0.0.0/0
SSH TCP 22 Anywhere 0.0.0.0/0
Security Group private ports:
Type Protocol Port Source Address Comments
CUSTOM TCP 3110 CUSTOM 172.16.0.0/24
ICMP ICMP 0-65535 Anywhere 0.0.0.0/0
SSH TCP 22 CUSTOM 172.16.0.0/2
