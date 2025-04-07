resource "aws_security_group" "main" {
  name        = var.security_group_name
  description = "Security group for ${var.security_group_name}"
  vpc_id      = var.vpc_id

  tags = var.tags

}

resource "aws_vpc_security_group_ingress_rule" "main" {
  count = length(var.ingress_rules)

  security_group_id = aws_security_group.main.id

  description = var.ingress_rules[count.index].description

  cidr_ipv4   = var.ingress_rules[count.index].cidr_blocks
  from_port   = var.ingress_rules[count.index].from_port
  ip_protocol = tostring(var.ingress_rules[count.index].protocol)
  to_port     = var.ingress_rules[count.index].to_port
}

resource "aws_vpc_security_group_egress_rule" "main" {
  count = length(var.egress_rules)

  security_group_id = aws_security_group.main.id

  description = var.egress_rules[count.index].description

  cidr_ipv4   = var.egress_rules[count.index].cidr_blocks
  from_port   = var.egress_rules[count.index].from_port
  ip_protocol = tostring(var.egress_rules[count.index].protocol)
  to_port     = var.egress_rules[count.index].to_port
}
