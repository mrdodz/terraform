##################################
# CREDENTIALS
##################################

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type = string
  sensitive = true
}

variable "proxmox_cloudinit_password" {
  type = string
  sensitive = true
}

variable "proxmox_ssh_public_key" {
  type = string
}

variable "gitlab_token" {
  type = string
  sensitive = true
}

variable "ansible_key_path" {
  type = string
  sensitive = true
}

##################################
# PROXMOX NODES
##################################

variable "proxmox_node_pve" {
  default = "name_of_your_proxmox_node"
}

##################################
# TEMPLATES
##################################

variable "ubuntu_2204_template" {
  default = "ubuntu-2204-template"
}

variable "ubuntu_2404_template" {
  default = "ubuntu-2404-template"
}

variable "rocky_9_template" {
  default = "rocky-9-template"
}


##################################
# OS SETTINGS
##################################

#* Cloud-Init
variable "ci_user_name" {
  default = "name_of_your_user"
}

variable "os_type_cloud_init" {
  default = "cloud-init"
}

variable "ipconfig0_dhcp" {
  default = "ip=dhcp"
}

#* SYSTEM SETTINGS

# CPU
variable "cpu_type_x86_64_v2_AES" {
  default = "x86-64-v2-AES"
}

# SCSI
variable "scsihw_virtio_scsi_single" {
  default = "virtio-scsi-single"
}

variable "storage_local_lvm" {
  default = "local-lvm"
}

variable "template_full_clone" {
  default = true
}

variable "boot_order_scsi0" {
  default = "order=scsi0"
}

variable "emulatessd_true" {
  default = true
}

variable "discard_true" {
  default = true
}

variable "iothread_true" {
  default = true
}

variable "emulatessd_false" {
  default = false
}

variable "discard_false" {
  default = false
}

variable "iothread_false" {
  default = false
}

# NETWORK

variable "network_id_0" {
  default = 0
}

variable "network_firewall_true" {
  default = true
}

variable "network_firewall_false" {
  default = false
}

variable "network_link_down_true" {
  default = true
}

variable "network_link_down_false" {
  default = false
}

variable "network_bridge_vmbr0" {
  default = "vmbr0"
}

variable "network_model_virtio" {
  default = "virtio"
}

# SERIAL
variable "serial_id_0" {
  default = 0
}

variable "serial_type_socket" {
  default = "socket"
}