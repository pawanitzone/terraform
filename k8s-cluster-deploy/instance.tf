resource "aws_key_pair" "project-kp" {
  key_name = "project-kp-key"
  public_key = "${var.ec2-public-key.public_key}"
}



#K8S Master Node
resource "aws_instance" "k8s-master" {
  ami = "${lookup(var.AMIS, var.AWS_REGION )}"
  instance_type = "${var.instance-type.us-east-1}"
  key_name = aws_key_pair.project-kp.id
  subnet_id = aws_subnet.k8s-public-subnet-1a.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.k8s_sg_public.id]
  iam_instance_profile = "${aws_iam_instance_profile.k8s-master-profile.name}"
  user_data = "${file("script.sh")}"
###Run if OS=CentOS then run these commands

  tags = {
    Name = "k8s-master"
  }
}




##K8S Worker Node1
resource "aws_instance" "k8s-worker-node-1a" {
  ami = "${lookup(var.AMIS, var.AWS_REGION )}"
  instance_type = "${var.instance-type.us-east-1}"
  key_name = aws_key_pair.project-kp.id
  subnet_id = aws_subnet.k8s-public-subnet-1a.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.k8s_sg_public.id]
  iam_instance_profile = "${aws_iam_instance_profile.k8s-workernode-profile.name}"
  user_data = "${file("script.sh")}"
  tags = {
    Name = "k8s-worker-node-1a"
  }

}

/**
##K8S Worker Node2
resource "aws_instance" "k8s-worker-node-1b" {
  ami = "${lookup(var.AMIS, var.AWS_REGION )}"
  instance_type = "${var.instance-type.us-east-1}"
  key_name = aws_key_pair.project-kp.id
  subnet_id = aws_subnet.k8s-public-subnet-1b.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.k8s_sg_public.id]
  iam_instance_profile = "${aws_iam_instance_profile.k8s-workernode-profile.name}"
  user_data = "${file("script.sh")}"
  tags = {
    Name = "k8s-worker-node-1b"
  }

} **/
/**
##K8S Worker Node3
resource "aws_instance" "k8s-worker-node-1c" {
  ami = "${lookup(var.AMIS, var.AWS_REGION )}"
  instance_type = "${var.instance-type.us-east-1}"
  key_name = aws_key_pair.project-kp.id
  subnet_id = aws_subnet.k8s-public-subnet-1c.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.k8s_sg_public.id]
  #iam_instance_profile = "${aws_iam_instance_profile.k8s-workernode-profile.name}"
  user_data = "${file("script.sh")}"
  tags = {
    Name = "k8s-worker-node-1c"
  }

}
**/
resource "aws_ec2_tag" "k8smaster-node-tag" {
  resource_id = aws_instance.k8s-master.id
  key         = "kubernetes.io/cluster/c-minion1"
  value       = "owned"
}
resource "aws_ec2_tag" "k8sworker-node-tag" {
  resource_id = aws_instance.k8s-worker-node-1a.id
  key         = "kubernetes.io/cluster/c-minion1"
  value       = "owned"
}
