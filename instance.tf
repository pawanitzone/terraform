resource "aws_key_pair" "project-kp" {
  key_name = "project-kp-key"
  public_key = "${var.ec2-public-key.public_key}"
}
/**
##IAM ROle for k8s-master
resource "aws_iam_policy" "k8s-master-policy" {
  name = "k8s-master-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "ec2:DescribeInstances",
                "ec2:DescribeRegions",
                "ec2:DescribeRouteTables",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVolumes",
                "ec2:CreateSecurityGroup",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:ModifyInstanceAttribute",
                "ec2:ModifyVolume",
                "ec2:AttachVolume",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:CreateRoute",
                "ec2:DeleteRoute",
                "ec2:DeleteSecurityGroup",
                "ec2:DeleteVolume",
                "ec2:DetachVolume",
                "ec2:RevokeSecurityGroupIngress",
                "ec2:DescribeVpcs",
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:AttachLoadBalancerToSubnets",
                "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
                "elasticloadbalancing:CreateLoadBalancer",
                "elasticloadbalancing:CreateLoadBalancerPolicy",
                "elasticloadbalancing:CreateLoadBalancerListeners",
                "elasticloadbalancing:ConfigureHealthCheck",
                "elasticloadbalancing:DeleteLoadBalancer",
                "elasticloadbalancing:DeleteLoadBalancerListeners",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeLoadBalancerAttributes",
                "elasticloadbalancing:DetachLoadBalancerFromSubnets",
                "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                "elasticloadbalancing:ModifyLoadBalancerAttributes",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:CreateTargetGroup",
                "elasticloadbalancing:DeleteListener",
                "elasticloadbalancing:DeleteTargetGroup",
                "elasticloadbalancing:DescribeListeners",
                "elasticloadbalancing:DescribeLoadBalancerPolicies",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:ModifyListener",
                "elasticloadbalancing:ModifyTargetGroup",
                "elasticloadbalancing:RegisterTargets",
                "elasticloadbalancing:SetLoadBalancerPoliciesOfListener",
                "iam:CreateServiceLinkedRole",
                "kms:DescribeKey"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
  })
}
resource "aws_iam_policy" "k8s-workernode-policy" {
  name = "k8s-workernode-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeRegions",
                "ec2:AttachVolume",
                "ec2:DetachVolume",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:BatchGetImage"
            ],
            "Resource": "*"
        }
    ]
  })
}

resource "aws_iam_role" "k8s-master-role" {
  name = "k8s-master-role"
  assume_role_policy = ""
  managed_policy_arns = [aws_iam_policy.k8s-master-policy.arn]
}
resource "aws_iam_role" "k8s-workernode-role" {
  name = "k8s-workernode-role"
  assume_role_policy = ""
  managed_policy_arns = [aws_iam_policy.k8s-workernode-policy.arn]
}

resource "aws_iam_instance_profile" "k8s-master-profile" {
  name = "k8s-master-profile"
  role = aws_iam_role.k8s-master-role.name
}
**/
#K8S Master Node
resource "aws_instance" "k8s-master" {
  ami = "${lookup(var.AMIS, var.AWS_REGION )}"
  instance_type = "${var.instance-type.us-east-1}"
  key_name = aws_key_pair.project-kp.id
  subnet_id = aws_subnet.k8s-public-subnet-1a.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.k8s_sg_public.id]
  #iam_instance_profile = "${aws_iam_instance_profile.k8s-master-profile.name}"
  tags = {
    Name = "k8s-master"
  }
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "${var.ubuntu-instance-username}"
    private_key = "${file("${var.ubunut-ec2-private-key}")}"
  }

}
/**
resource "aws_iam_instance_profile" "k8s-workernode-profile" {
  name = "k8s-workernode-profile"
  role = aws_iam_role.k8s-workernode-role.name
}
**/
##K8S Worker Node1
resource "aws_instance" "k8s-worker-node-1a" {
  ami = "${lookup(var.AMIS, var.AWS_REGION )}"
  instance_type = "${var.instance-type.us-east-1}"
  key_name = aws_key_pair.project-kp.id
  subnet_id = aws_subnet.k8s-public-subnet-1a.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.k8s_sg_public.id]
  #iam_instance_profile = "${aws_iam_instance_profile.k8s-workernode-profile.name}"
  tags = {
    Name = "k8s-worker-node-1a"
  }
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "${var.ubuntu-instance-username}"
    private_key = "${file("${var.ubunut-ec2-private-key}")}"
  }
}

##K8S Worker Node2
resource "aws_instance" "k8s-worker-node-1b" {
  ami = "${lookup(var.AMIS, var.AWS_REGION )}"
  instance_type = "${var.instance-type.us-east-1}"
  key_name = aws_key_pair.project-kp.id
  subnet_id = aws_subnet.k8s-public-subnet-1b.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.k8s_sg_public.id]
  #iam_instance_profile = "${aws_iam_instance_profile.k8s-workernode-profile.name}"
  tags = {
    Name = "k8s-worker-node-1b"
  }
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "${var.ubuntu-instance-username}"
    private_key = "${file("${var.ubunut-ec2-private-key}")}"
  }
}

##K8S Worker Node3
resource "aws_instance" "k8s-worker-node-1c" {
  ami = "${lookup(var.AMIS, var.AWS_REGION )}"
  instance_type = "${var.instance-type.us-east-1}"
  key_name = aws_key_pair.project-kp.id
  subnet_id = aws_subnet.k8s-public-subnet-1c.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.k8s_sg_public.id]
  #iam_instance_profile = "${aws_iam_instance_profile.k8s-workernode-profile.name}"
  tags = {
    Name = "k8s-worker-node-1c"
  }
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "${var.ubuntu-instance-username}"
    private_key = "${file("${var.ubunut-ec2-private-key}")}"
  }
}
#resource "aws_ec2_tag" "k8s-node-tag" {
#  key = "kubernetes.io/cluster/c-minion1"
#  value = "owned"
#  resource_id = [aws_instance.k8s-master.id, aws_instance.k8s-worker-node-1a.id, aws_instance.k8s-worker-node-1b.id, aws_instance.k8s-worker-node-1c.id]
#}