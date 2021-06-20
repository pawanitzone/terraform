
# To Deploy kubernetes cluster on AWS, use this terraform code.

1. First replace AWS access and secret key in 'terraform.tfvars'
2. Install terraform command in you system.
3. Now deploy K8S cluster
   -> cmd: # terraform apply
4. After successful deployment, login to master instance and initiate master node
   -> cmd: # kubeadm init
   -> # Run mkdir and copy command provides in output after kubeadm init finieshed
   -> # Also copy kubeadm join command and run on each worker node to join master
   
