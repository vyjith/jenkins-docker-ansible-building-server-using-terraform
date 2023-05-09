output "minikubeip" {

    value = "http://${aws_instance.minikube.public_ip}"
  
}


