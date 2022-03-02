variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "ubuntu-instance-username" {
  default = "ubuntu"
}

variable "AMIS" {
  type = map
  default = {
    us-east-1 = "ami-0ee02acd56a52998e"
    ap-south-1 = "ami-0ee02acd56a52998e"
    eu-west-1 = "ami-0ee02acd56a52998e"
  }
}

variable "instance-type" {
  type = map
  default = {
    us-east-1 = "t3a.small"
  }
}

variable "ec2-public-key" {
  type = map
  default = {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDmSKIq8GcxEgBKD0dudkWBuvnRP/RLD7nObEOQaHoP/1FNpyF0hYBHkTcXBn5mMD/CZKFY6Ph1v1xKcGbcqDX785JQDwW0xNS5wuAHCTCb3c90472Ey52oPXizalMTHXwh+cUPECSey1Xx74/oOxnIZ7g1cti+gtaUGTR0S95S6EtZ+5CB81qEFuIiwsVKqTFhi32C+RGX80Zc41Qx17n5axP/NH1KBmXkX3HlEBp+v3hjPEozPAobEWRB5CtnJcMU6Xlsq8HP2p1/aQa3+TCOe10mjIyW8EUR79ifiuOgTQZZD640tletmF6caff246dTecxpuLNx9oFVHiU0/ezDClxuPp9JkVAk/O6L3iFsTt2pOLobkkuMu++TxSh6pi4USj/N0840g1Migp42+RNPqG8j53gS01A0sEGotuLBiBL6SepUGF3JPOEvEnkqKPcMOGMisn3JY/jncP71RjvR0RHwn+QyLFgpNyP+WDlaIYVvGUCRjRxxOY/cOoJBEf0= pawan@LAPTOP-MGNJRS7N"
  }
}

variable "ubunut-ec2-private-key" {
  default = "~/.ssh/id_rsa"

}

/**
variable "k8s-vpc-public-subnet" {
  type = list
  default = ["172.168.1.0/24", "172.168.2.0/24", "172.168.3.0/24"]
}
variable "vpc_subnet_names" {
  type = list
  default = ["k8s-public-subnet-1a", "k8s-public-subnet-1b", "k8s-public-subnet-1c"]
}
variable "vpc_subnet_azs" {
  type = list
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
**/