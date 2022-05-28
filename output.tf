output "jenkinsip" {

    value = "http://${aws_instance.jenkins.public_ip}:8080"
  
}

output "dockerip" {

    value = "Docker IP is ${aws_instance.docker.public_ip}"
}



output "ansible-IP" {

    value = "Ansible ip is ${aws_instance.ansible.public_ip}"
  
}
