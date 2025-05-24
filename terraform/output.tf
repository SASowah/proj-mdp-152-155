output "k8s_workstation_public_ip" {
  value       = aws_instance.k8s_workstation.public_ip
  description = "Public IP of the Kubernetes workstation node"
}

output "k8s_workstation_private_ip" {
  value       = aws_instance.k8s_workstation.private_ip
  description = "Private IP of the Kubernetes workstation node"
}

output "ansible_master_public_ip" {
  value       = aws_instance.ansible_master.public_ip
  description = "Public IP of the Ansible master node"
}

output "ansible_master_private_ip" {
  value       = aws_instance.ansible_master.private_ip
  description = "Private IP of the Ansible master node"
}

output "kops_state_store_bucket_name" {
  value       = aws_s3_bucket.k8s_bucket.bucket
  description = "Name of the S3 bucket used as the KOPS state store"
}