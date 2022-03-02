
# To Deploy kubernetes cluster on AWS, use this terraform code.

1. First replace AWS access and secret key in 'terraform.tfvars'
2. Install terraform command in you system.
3. Now deploy K8S cluster
    cmd: # 1. terraform init, 2. terraform apply
4. After successful deployment, login to master instance and initiate master node
cmd: # kubeadm init
# Run mkdir and copy command provides in output after kubeadm init finieshed
# Also copy kubeadm join command and run on each worker node to join master
   
# Error troublshooting: [kubelet-check] The HTTP call equal to 'curl -sSL http://localhost:10248/healthz' failed with error: Get "http://localhost:10248/healthz": dial tcp 127.0.0.1:10248: connect: connection refused.
- vi  /etc/docker/daemon.json
- add this contents: 
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}

## Deploy Weave net on k8s
- # kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
