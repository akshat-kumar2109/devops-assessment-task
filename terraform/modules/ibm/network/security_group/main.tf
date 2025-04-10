resource "ibm_is_security_group" "security_group" {
  name           = var.security_group_name
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
  tags           = var.tags
}

resource "ibm_is_security_group_rule" "rules" {
  for_each  = var.rules
  group     = ibm_is_security_group.security_group.id
  direction = each.value.direction
  remote    = each.value.remote

  dynamic "tcp" {
    for_each = each.value.protocol == "tcp" ? [1] : []
    content {
      port_min = each.value.port_min
      port_max = each.value.port_max
    }
  }

  dynamic "udp" {
    for_each = each.value.protocol == "udp" ? [1] : []
    content {
      port_min = each.value.port_min
      port_max = each.value.port_max
    }
  }

  dynamic "icmp" {
    for_each = each.value.protocol == "icmp" ? [1] : []
    content {
      type = each.value.icmp_type
      code = each.value.icmp_code
    }
  }
} 