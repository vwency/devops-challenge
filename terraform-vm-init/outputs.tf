output "master_name" {
  description = "Name of the master node"
  value       = libvirt_domain.master.name
}

output "master_id" {
  description = "ID of the master node"
  value       = libvirt_domain.master.id
}

output "worker_names" {
  description = "Names of worker nodes"
  value       = [for worker in libvirt_domain.worker : worker.name]
}

output "worker_ids" {
  description = "IDs of worker nodes"
  value       = [for worker in libvirt_domain.worker : worker.id]
}

output "pool_path" {
  description = "Path to the storage pool"
  value       = libvirt_pool.k8s_pool.target.path
}

output "base_image_path" {
  description = "Path to the base image"
  value       = libvirt_volume.base_image.path
}

output "network_name" {
  description = "Network name used by VMs"
  value       = var.network_name
}

output "get_ips_command" {
  description = "Command to get IP addresses of VMs"
  value       = "virsh domifaddr k8s-master && virsh domifaddr k8s-worker-1"
}
