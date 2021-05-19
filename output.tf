output "k8s-master-pub-ip" {
  value = aws_instance.k8s-master.public_ip
}

output "k8s-workernode-1a-pub-ip" {
  value = aws_instance.k8s-worker-node-1a.public_ip
}

output "k8s-workernode-1b-pub-ip" {
  value = aws_instance.k8s-worker-node-1b.public_ip
}

output "k8s-workernode-1c-pub-ip" {
  value = aws_instance.k8s-worker-node-1c.public_ip
}