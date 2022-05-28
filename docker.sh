#!/bin/bash

sudo yum install docker -y

sudo usermod -aG docker ec2-user

sudo systemctl start docker

sudo systemctl enable docker
