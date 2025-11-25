terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.9.0"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri
}

resource "libvirt_pool" "k8s_pool" {
  name = "k8s-pool"
  type = "dir"
  target = {
    path = "/var/lib/libvirt/images/k8s"
  }
}

resource "libvirt_volume" "base_image" {
  name   = "base-image.qcow2"
  pool   = libvirt_pool.k8s_pool.name
  format = "qcow2"
  
  create = {
    content = {
      url = var.base_image_url
    }
  }
}

resource "libvirt_volume" "master_volume" {
  name     = "master-disk.qcow2"
  pool     = libvirt_pool.k8s_pool.name
  capacity = var.master_disk_size
  format   = "qcow2"
  
  backing_store = {
    path   = libvirt_volume.base_image.path
    format = "qcow2"
  }
}

resource "libvirt_volume" "worker_volume" {
  count    = var.worker_count
  name     = "worker-${count.index + 1}-disk.qcow2"
  pool     = libvirt_pool.k8s_pool.name
  capacity = var.worker_disk_size
  format   = "qcow2"
  
  backing_store = {
    path   = libvirt_volume.base_image.path
    format = "qcow2"
  }
}

resource "libvirt_domain" "master" {
  name   = "k8s-master"
  memory = var.master_memory
  vcpu   = var.master_vcpu
  type   = "kvm"

  os = {
    type         = "hvm"
    arch         = "x86_64"
    boot_devices = ["hd", "network"]
  }

  devices = {
    disks = [
      {
        source = {
          file = libvirt_volume.master_volume.path
        }
        target = {
          dev = "vda"
          bus = "virtio"
        }
      }
    ]
    interfaces = [
      {
        type  = "network"
        model = "virtio"
        source = {
          network = var.network_name
        }
      }
    ]
    consoles = [
      {
        type        = "pty"
        target_type = "serial"
        target_port = "0"
      }
    ]
  }
}

resource "libvirt_domain" "worker" {
  count  = var.worker_count
  name   = "k8s-worker-${count.index + 1}"
  memory = var.worker_memory
  vcpu   = var.worker_vcpu
  type   = "kvm"

  os = {
    type         = "hvm"
    arch         = "x86_64"
    boot_devices = ["hd", "network"]
  }

  devices = {
    disks = [
      {
        source = {
          file = libvirt_volume.worker_volume[count.index].path
        }
        target = {
          dev = "vda"
          bus = "virtio"
        }
      }
    ]
    interfaces = [
      {
        type  = "network"
        model = "virtio"
        source = {
          network = var.network_name
        }
      }
    ]
  }
}
