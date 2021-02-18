provider "google" {
 credentials = file("SAKEY.json")
 project     = "gcp-training-01-303001"
 region = "us-east1"
}