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

# ACTIONABLE ITEMS:
# When spinning up with DHCP, it would be nice to get the VM's private IP -->

# Example 1 - Echo VM's IP
  provisioner "local-exec" {
    when = create
    command = "echo ${self.default_ipv4_address} ${self.name}"
  }

# Example 2 - We could also copy IP/Hostname to file (could be hosts file, ansible inventory, etc)
  provisioner "local-exec" {
    when = create
    command = "echo ${self.default_ipv4_address} ${self.name} >> test.txt"
  }

# Example 3 - Run Ansible playbook
  provisioner "local-exec" {
    when = create
    command = "ansible-playbook -i ${self.default_ipv4_address}, --private-key ${var.ansible_key_path} your_playbook.yaml"       #Note the comma is required there but haven't tested
  }

}

# Or use `output` outside of "proxmox_vm_qemu" resource to get IP
# Note the VM name is necessary here

output "proxmox_ip_address_default" {
  description = "Current IP Default"
  value = proxmox_vm_qemu.test-1.*.default_ipv4_address
}