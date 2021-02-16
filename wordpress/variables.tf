variable "startup_script" {
  default     = <<EOT
  #!/bin/bash
  sudo ufw allow 22
  sudo apt-get -y update
  sudo apt-get -y install git
  git clone https://github.com/Schrodinger-kat/google-cloud-activity.git
  cd /google-cloud-activity/wordpress/
  sudo sh install.sh
  EOT
}