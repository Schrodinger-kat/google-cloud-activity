#!/bin/bash
  sudo ufw allow 22
  sudo apt-get update
  sudo apt install -y apache2
  sudo apt-get install -y git