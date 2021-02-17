variable "startup_script" {
  default     = <<EOT
  #!/bin/bash
  sudo ufw allow 22
  sudo apt-get update
  sudo apt install -y apache2
  sudo apt-get install -y git
  EOT
}

/*
 git clone https://github.com/Schrodinger-kat/google-cloud-activity.git
  cd /google-cloud-activity/wordpress/
  sudo sh install.sh
 */