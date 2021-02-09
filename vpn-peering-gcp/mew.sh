gcloud compute networks create jishnn-vpc-nw1 --subnet-mode custom
gcloud compute networks subnets create nw1-sn1 --network jishnn-vpc-nw1 --range 10.0.0.0/16 --region us-central1
gcloud deployment-manager deployments create jishnn-nw1-vmi --config mew.yaml
gcloud compute firewall-rules create jishnn-nw1-fw --network jishnn-vpc-nw1 --allow tcp:22,icmp
