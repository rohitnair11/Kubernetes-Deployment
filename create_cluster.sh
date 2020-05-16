eksctl create cluster --name capstone --nodegroup-name standard-workers --node-type t2.micro --nodes 2 --nodes-min 1 --nodes-max 2 --node-ami auto --region us-east-2 

aws eks --region us-east-2 update-kubeconfig --name capstone
