# Get the default Ubuntu image if no custom image is specified
data "ibm_is_image" "os_image" {
  name = coalesce(var.image_id, "ibm-ubuntu-22-04-minimal-amd64-1")
}

# Create VSI
resource "ibm_is_instance" "instance" {
  count          = var.instance_count
  name           = "${var.name_prefix}-instance-${count.index + 1}"
  vpc            = var.vpc_id
  zone           = var.zone
  profile        = var.instance_profile
  image          = data.ibm_is_image.os_image.id
  keys           = var.ssh_key_ids
  resource_group = var.resource_group_id

  primary_network_interface {
    subnet          = var.subnet_id
    security_groups = var.security_group_ids
  }

  boot_volume {
    name = "${var.name_prefix}-boot-${count.index + 1}"
    size = var.boot_volume_size
  }

  tags = concat(var.tags, ["instance:${var.name_prefix}-${count.index + 1}"])
}

# Create Floating IP
resource "ibm_is_floating_ip" "floating_ip" {
  count          = var.create_floating_ip ? var.instance_count : 0
  name           = "${var.name_prefix}-fip-${count.index + 1}"
  target         = ibm_is_instance.instance[count.index].primary_network_interface[0].id
  resource_group = var.resource_group_id
  tags           = concat(var.tags, ["instance:${var.name_prefix}-${count.index + 1}", "environment:${var.environment}"])

  depends_on = [ibm_is_instance.instance]
}

# Create security group rules for each instance
resource "ibm_is_security_group_rule" "allow_inbound_ssh" {
  count     = var.create_floating_ip ? var.instance_count : 0
  group     = var.security_group_ids[0]
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 22
    port_max = 22
  }
}

# Allow inbound HTTP traffic
resource "ibm_is_security_group_rule" "allow_inbound_http" {
  count     = var.create_floating_ip ? var.instance_count : 0
  group     = var.security_group_ids[0]
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 80
    port_max = 80
  }
}

# Allow inbound HTTPS traffic
resource "ibm_is_security_group_rule" "allow_inbound_https" {
  count     = var.create_floating_ip ? var.instance_count : 0
  group     = var.security_group_ids[0]
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 443
    port_max = 443
  }
}

resource "ibm_is_security_group_rule" "allow_outbound" {
  count     = var.create_floating_ip ? var.instance_count : 0
  group     = var.security_group_ids[0]
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_instance_network_interface_floating_ip" "main" {
  count             = var.create_floating_ip ? var.instance_count : 0
  instance          = ibm_is_instance.instance[count.index].id
  network_interface = ibm_is_instance.instance[count.index].primary_network_interface[0].id
  floating_ip       = ibm_is_floating_ip.floating_ip[count.index].id
}
