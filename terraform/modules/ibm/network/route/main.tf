resource "ibm_is_vpc_routing_table" "routing_table" {
  name = var.routing_table_name
  vpc  = var.vpc_id
}

resource "ibm_is_vpc_routing_table_route" "routes" {
  for_each       = var.routes
  vpc            = var.vpc_id
  routing_table  = ibm_is_vpc_routing_table.routing_table.id
  name           = each.key
  zone           = "${var.region}-1"
  destination    = each.value.destination
  next_hop      = each.value.next_hop
} 