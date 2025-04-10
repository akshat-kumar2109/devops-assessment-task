# Get the latest Ubuntu image
data "ibm_is_image" "ubuntu" {
  name = "ibm-ubuntu-22-04-minimal-amd64-1"
}

# Create VSI
resource "ibm_is_instance" "instance" {
  count          = var.instance_count
  name           = "${var.name_prefix}-instance-${count.index + 1}"
  vpc            = var.vpc_id
  zone           = var.zone
  profile        = var.instance_profile
  image          = data.ibm_is_image.ubuntu.id
  keys           = var.ssh_key_ids
  resource_group = var.resource_group_id

  primary_network_interface {
    subnet          = var.subnet_id
    security_groups = var.security_group_ids
  }

  tags = concat(var.tags, ["ansible_managed:true"])

  boot_volume {
    name = "${var.name_prefix}-boot-${count.index + 1}"
    size = var.boot_volume_size
  }
}

# Create Floating IP
resource "ibm_is_floating_ip" "floating_ip" {
  count          = var.create_floating_ip ? var.instance_count : 0
  name           = "${var.name_prefix}-fip-${count.index + 1}"
  target         = ibm_is_instance.instance[count.index].primary_network_interface[0].id
  zone           = var.zone
  resource_group = var.resource_group_id
  tags           = var.tags
} 