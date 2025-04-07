#! 105
resource "proxmox_vm_qemu" "example_vm_name" {

# VM General Settings
  target_node = var.proxmox_node_pve
  vmid = "105"
  name = "example_vm_name"

# VM CPU/MEM
  cpu_type  = var.cpu_type_x86_64_v2_AES
  cores     = 8
  sockets   = 1
  memory    = 8192

# VM OS Settings
  clone       = var.ubuntu_2204_template
  scsihw      = var.scsihw_virtio_scsi_single
  full_clone  = var.template_full_clone
  boot        = var.boot_order_scsi0
  onboot      = false                                     # Start VM on proxmox boot
  agent       = 1                                         # Enable QEMU Guest Agent
  vm_state    = "stopped"

# Cloud-Init stuff
  os_type     = var.os_type_cloud_init
  ipconfig0   = var.ipconfig0_dhcp
  ciuser      = var.ci_user_name
  cipassword  = var.proxmox_cloudinit_password
  sshkeys     = var.proxmox_ssh_public_key

# VM Disk Settings
  disks {
    ide {
      ide0 {
        cloudinit {
          storage = var.storage_local_lvm
        }
      }
    }
    scsi {
      scsi0 {
      disk {
        size        = "15G"
        backup      = false
        storage     = var.storage_local_lvm
        emulatessd  = var.emulatessd_true
        discard     = var.discard_true
        iothread    = var.iothread_true
        }
      }
    }
  }

# VM Network Settings
  network {
    id          = var.network_id_0
    bridge      = var.network_bridge_vmbr0
    firewall    = var.network_firewall_false
    link_down   = var.network_link_down_false
    model       = var.network_model_virtio
  }

# VM Serial Settings
  serial {
    id    = var.serial_id_0
    type  = var.serial_type_socket
  }
}
