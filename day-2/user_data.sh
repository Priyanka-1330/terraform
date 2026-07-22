#!/bin/bash
sudo dnf update
sudo dnf install httpd
sudo systemctl enable httpd.service
sudo systemctl start httpd.service