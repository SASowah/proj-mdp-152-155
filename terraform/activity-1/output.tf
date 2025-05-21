output "build_server_ip" {
    value = aws_instance.build_server.public_ip
    description = "the public IP address of the build server"
  
}

output "tomcat_server_ip" {
    value = aws_instance.tomcat_server.public_ip
    description = "the public IP address of the tomcat server"
  
}

output "tomcat_server_url" {
    value = "http://${aws_instance.tomcat_server.public_ip}:8080/*"
    description = "the URL of the tomcat server"
}