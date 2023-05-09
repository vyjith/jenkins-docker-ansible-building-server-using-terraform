output "minikubeip" {

    value = "${aws_instance.minikube.public_ip}"
  
}


