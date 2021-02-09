gcloud compute networks create jishnn-vpc-nw2 --subnet-mode custom
gcloud compute networks subnets create nw2-sn1 --network jishnn-vpc-nw2 --range 10.8.0.0/16 --region us-central1
gcloud deployment-manager deployments create jishnn-nw2-vmi --config mewtwo.yaml
gcloud compute firewall-rules create jishnn-nw2-fw --network jishnn-vpc-nw2 --allow tcp:22,icmp
