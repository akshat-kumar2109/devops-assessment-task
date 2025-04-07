locals {
  subnet_to_route_table = flatten([
    for rt_index, rt in var.route_tables : [
      for subnet_id in rt.subnet_ids : {
        subnet_id = subnet_id
        rt_index  = rt_index
      }
    ]
  ])
}

resource "aws_route_table" "main" {
  count  = length(var.route_tables)
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.route_tables[count.index].routes
    content {
      cidr_block                = route.value.cidr_block
      gateway_id                = route.value.gateway_id
      nat_gateway_id            = route.value.nat_gateway_id
      network_interface_id      = route.value.network_interface_id
      vpc_peering_connection_id = route.value.vpc_peering_connection_id
    }
  }

  tags = merge(
    {
      Name = var.route_tables[count.index].name
    },
    var.tags
  )
}

resource "aws_route_table_association" "main" {
  count          = length(local.subnet_to_route_table)
  subnet_id      = local.subnet_to_route_table[count.index].subnet_id
  route_table_id = aws_route_table.main[local.subnet_to_route_table[count.index].rt_index].id
}
