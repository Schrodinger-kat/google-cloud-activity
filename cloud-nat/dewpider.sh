gcloud compute networks create jishnn-pnw --subnet-mode custom
gcloud compute networks subnets create dewspider-nw-sub --network jishnn-pnw --region us-central1 --range 10.130.0.0/20
